Return-Path: <linux-fsdevel+bounces-4008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E58C7FAFAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 02:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520501C20A8B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 01:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99121FBA;
	Tue, 28 Nov 2023 01:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JJf/o1+A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yuJPX1uY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6EED4B;
	Mon, 27 Nov 2023 17:38:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS1Y1av013813;
	Tue, 28 Nov 2023 01:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=yap5OOUkGgIId6d5yUlksBRkOTSOCm3T89U+tb7wc/w=;
 b=JJf/o1+ANfNkkl9pQxcnSxlGNG/SjYQocBY7alxoATpaSd3xh0XH84g0JS3R/5I3hBTq
 O3sILy7YNOTLi2grC4njnSRfyhMMBWBSHczVtZgV92ZPnr5gQNUTYt+jJ+lpZlRN1aza
 g0egcTpMW849wWctrNFnQV9SIDR4j27maSHasihF5eF1KVqyeXr9LmGr9VDUPVhdwcpW
 patj2nOm98IAYZZyTS+4TcjAaZSYu/+Hcmo0DMoKs8unzpjOvZe/7D9FBEiUVWKIXdYc
 m5cN811Wm6X1Dren3Cmt5FcMs9JaMq/RC8uHk4XvO+7Li2Fte+Dqtb1NslHS577weayK yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8hu4h92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 01:38:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS0gBZk027070;
	Tue, 28 Nov 2023 01:38:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7ccd11a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 01:37:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bvl0USHxMSpGvNKLlWtS3yjZ5nmhTNOl2lrHPqf65AcUaM55xYwSYJKIU2enOYszd+0iYr2M5S7ilFqNcB1HIanae03IxHjvOwdE2pEIkoBfP5BsGKTUw5x7Q6GRjxnSxa1f28gcnh4nxCoGqlKw+RqB9+GUSkHPcelrsCLl+UKtmrpaKTS2RIS9UlCReb7BT0XkldKAF8rWlsk0RQvO3xpd/kwZ4Eb2ILBqk6uu53UGgBo78hYI8kIYVszQp5qIFJinEnr/gqoSShQMKglpH8OykaA9oBfEWh65yTVrViDZDoetnsR6n3ZY2EESSYG+IumHRdqcAsmkobFQ/ViWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yap5OOUkGgIId6d5yUlksBRkOTSOCm3T89U+tb7wc/w=;
 b=VmLxy671k/r6K579Elwe7d1RnpiDuGlZCe2HzmJ8eUgjXKVVFMB3Bob0e/PmsGxROG/XboKQ+YsgGzW5f4/oJgOckMzadj+sAhoIBYYy2Um7p4p0XfaIYScM1ICj+ZKFuIWxYHlhbF6+8ZdSaIwk5UoTo5LHo3AOqvBgOf8DgJ/LfrUvlBRFz/J/POC3gUN5EPz0CeKjz406pXVZVsvOrlPhSYpLTBlnPMWv00kZV3z3XvR/K/A7T66jLLW44egHHOEaeYLwbXRQAaIoflUIbtIQ1H/PSD1EV8rHALRa/Q8mbRbneX5a9Ac4tBEcYdyt0eE0jwTa0iDd9xGNFtnb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yap5OOUkGgIId6d5yUlksBRkOTSOCm3T89U+tb7wc/w=;
 b=yuJPX1uYW+lNW4MRxt/bXcz2JAnr6bFaQvXcK41h3iaBK1kCW6hPpddxro2G72u8qGYnh3Ti1G2F4xKHjH2Se1gUhZdp0g8shF8yzsKWiZlOecYGdfpdEzAbmp6UC9CFvsEA7A8jtH6tsWQ4TaC8GsjJn9sAsQMBKex5EbwjElE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5003.namprd10.prod.outlook.com (2603:10b6:610:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 01:37:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 01:37:57 +0000
Date: Mon, 27 Nov 2023 20:37:53 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <ZWVEcasahyVQ4QqV@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170113056683.7109.13851405274459689039@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:610:5b::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 07702242-56c9-491b-8a38-08dbefb2a5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	meeZAHDAlFYM1C/oScEarazpjPnk9zqQ+6seMoVYPx/GTcavKxekwHlkUN6QUd9q2a22zSZtCqfuxN+0liFOcHEzwx/CH5+LlMH6VAfxiErQVviLkuSbwwhCU9Aqmw/g6NN4vF60BV3D15BmUvYrlKIvS+EaWBU04P5CanugG9tJgiCov2a4qNm4VGFiEakTy3s7BdzWgKPOocufQ204pskq+6V7btZi0xJylZskl5rtmgw1BUfq9GHLhoNcfErcJBKJlYMnTIyMBVy6fo1nLoJFp0mov0QMbFM57eee9IeFKUyFeksTKR0m56iiEs9iV2yWTSrdqgx4GDcQpBW4MShAlPRe9XCfaJUJeU+Anpu0/796vziVcb/urswnDMbbJhSbJIsR1IMhi6v17EZKIU9nT1lsNvQYuG5Qkqjl+I+JSK0Fb1L1Y0cOiOx3f1DdvkqVvSpc3AJDvt7mqzzzgMtlrGKLMwecMV9K4HKzotVLx5QDe59y1EnSvU9C3jMgbiihtyEhP3mM3hTRLwWBdPqFxrdgESrClcx5pQT5yDE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(86362001)(41300700001)(4326008)(8936002)(8676002)(6916009)(54906003)(316002)(66476007)(66556008)(9686003)(66946007)(6512007)(6666004)(6506007)(478600001)(6486002)(966005)(5660300002)(7416002)(2906002)(44832011)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UhRLpKpexdLUn5XdIGSQSvep5u+jNt1Jvgu/LigjRrV+W7DCEzA7Zgs/79VF?=
 =?us-ascii?Q?AHtoybREc1rFfgNTsB/8L1Tl4hDMB962RpO0ebFr2pJO5rjFgwTNOX0nwROc?=
 =?us-ascii?Q?pLSZMnDio5jVzIGMhsAnx7nE81+tkklZTzm9UqkLcWIHuaSJVuFGFpmr0BP+?=
 =?us-ascii?Q?xuzog/nyXdET6ZKkzqbkL6qcFdY+7aQifGUBZrY5TjzOYU8Qmik3K72dc7g3?=
 =?us-ascii?Q?P1Te/uelPu/ky9Xy6cT43HpvyQ6xs2SHsm6f8KJzkBg8NVuGGfLHoMiLHekz?=
 =?us-ascii?Q?YTnBiXbm+6aGGsHbq3ZuFzpyG4XkTqGBdsImuVQNvvlcng7cRoA+RTz+aFD7?=
 =?us-ascii?Q?A0Q/UjKffWFCXFP+j+qL0uoczxAKfa3jmYQwQR0DLlaHYumBleSsVVeev8T8?=
 =?us-ascii?Q?zOjYHENUjtggptbF7/aDPCFp1/xbHS/vAcQOW/I3WbINnl/rA8AxawH6MYx7?=
 =?us-ascii?Q?sDrhYeFZuZfvB3xJXi9ISa5fEiybtAL8VJ8idYbMp1Hj7WPCzuLUJuddXH8Z?=
 =?us-ascii?Q?EzNDNpG8zXb8ZOypNxdaJLl05CMrO+D9vlrJfSlX3O0tXeN4vY0tzB9nNmcY?=
 =?us-ascii?Q?D9ZV/FSFggcQLAI4+cDlu58lJRcArNKAyqrSN/ayZJCjsoHl7bSerggzdTjS?=
 =?us-ascii?Q?MLjAniOF2r+KtLAbdn+/ycgJkKs7cw52NRJM7mOZWD1EeSi+2+MyVartFRbN?=
 =?us-ascii?Q?VmsBi3Lh7+DYHwbWn0v6c4aU4j6ZGLcDe1LDu+9PO4N4ckb245gwTZUZx2W0?=
 =?us-ascii?Q?eAcJxZextWt0p4fHZtRZQyhTqy9xGhDfoQHJVNeGIiPhA5q22RCAqTlNVRlb?=
 =?us-ascii?Q?T1r15hIL02w6Pk6en56uHh45kpOa/W8p5D5f0lyClqqUEKXP1+kL8MbEitHH?=
 =?us-ascii?Q?KSBS5e25MFnn6p+z1TpivMKoIBLphzNN/KiPRM52amnpKkmwtjsiDhijDHCW?=
 =?us-ascii?Q?F3dzWHuO55y2NPzMYYVOvf/gP/nsiz79VIhB6LGckXon5ZwVUA8JNB1xRq8R?=
 =?us-ascii?Q?vkM14paZ+wTDArLI7cz0yiHNemrJ5aAbbdMRM0a0QPZucE6RICIjxeHmd5wE?=
 =?us-ascii?Q?i9CUamdfyNWtnHWXRAjvdnHkwC0OKE2k5Yu74aTYpMERkbC6qTZsYv9WmNnE?=
 =?us-ascii?Q?vJxuHsF3M+7F3v3gXm9SzbdfEhqlLUxkqtsWKBHCfxSUWILJQwO5R4eXpT8D?=
 =?us-ascii?Q?cOh3Wmeh4/QIKxdu3UTcK6SMCX2m6O+dPSa9J2WiBNAdPPvlaMHQ3vm92h+H?=
 =?us-ascii?Q?+zkQrpTAsEk0nv8d0ZOSb7BieM+PyQD8YDKmAsr5fq+rJarWJl0YXQLBvEsZ?=
 =?us-ascii?Q?H6HV4nu8e3hwb/YbF3J9Iwgo3gaI84BWNqN1Q/3HGlOghzF21jBEDmzRM3b9?=
 =?us-ascii?Q?oMATQ+xGkX9POVePbfaombq65KRD3v2IWyiB8NUMijAGahkN3zs8yvoLjFYk?=
 =?us-ascii?Q?nvuKp1dlBl+KIxVKTqdb+x6sBNiuJ2XhPxDP4YXRcix78xynm+80a6m6evVG?=
 =?us-ascii?Q?gfIAAfE+M5Vh8ggb6hh3uCchzpTBxQ89KpsfVrkpBKm2nal8n6XxZPyff7uZ?=
 =?us-ascii?Q?+uxgV7Nkbmba5UHUlZGbAF+bAb4s1dWXnqthXdHpeKhpnEu12/NrJXKyrMua?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?aIr/Unh7MisvbKKnhoASn0GRlffTRIPB26lGM/83affFJYJx55RKyUATWUrj?=
 =?us-ascii?Q?nrx7v87U/0uT9hUjnLIrXHuhwv5cr2sltWELqx23Q9wsRuP2o1Ja7PdHiqfA?=
 =?us-ascii?Q?NNx3PcpBzuQGAJlIax+ovd/Oo5tHJagWwL059hl12Oin6zfbd5nXjOgBxWMv?=
 =?us-ascii?Q?q3PpcczdeCeOy7O0LSh83LmcILSJhiabf6C3c94+9L4RRdJd19QoKNQKUx/F?=
 =?us-ascii?Q?9Sc1FP7FMP2ycYk5WYmxxNvVUuAmtZi+Vy6wZP0XEitrOs3cXAF/ej83rtnA?=
 =?us-ascii?Q?1dU1ksDWcV5zpNBkzgPY/ezdyZNoRekViBedojySXebZKeOGADQPIvcUIa8p?=
 =?us-ascii?Q?A4Zy3iJnlXmzPtVCfX+MegxHQ2yZvQjaMrpeyLG50FmvorCjwQFFBMG8mPBS?=
 =?us-ascii?Q?pcO2ll9ws/1zyoVIKNwsugIN3decftXvqSyqtMa3G7yno4YyyHSUoGzbTjkF?=
 =?us-ascii?Q?syj06LarebDwy1iwX7mwUcP514TpFPHU3NRoKCjy2EmzMtKQnC09fJj+h9Fr?=
 =?us-ascii?Q?fjvK/736LEeLAwtPnHN6shX/AX8b4R76reMOA+QROtK65UjmOBRT/aOl6wxH?=
 =?us-ascii?Q?ZtzOF6s+ckoFS/7VLH80UBuQLHl1WjTXJDbfQr858FyFA+8W04jN3VDfDR5v?=
 =?us-ascii?Q?rIcnkdATrPO6yLwFKp38UedlhPYKFpZH/wI1BsynFWOwr3vrSjmtO3v2B+kE?=
 =?us-ascii?Q?Wx/FRBCX92DD08sy1IRNbYWJVH4sTQ4/Z/cgddjvw4kfeStvc9YtmRDR4oWs?=
 =?us-ascii?Q?1/CM+Tkip33xuFOqU86pu1QuVbjn8zMISmuPCCe4Q84aabdysMQDGWhVFaAe?=
 =?us-ascii?Q?WoIfstY47q3Y5FsEW8h9FCDoEb0nZlXv3elqeJG4qt8BQSJv/iJbVf/RVvSh?=
 =?us-ascii?Q?vi7FpGJQ5qxl0BJEu8KAvhXDBl6piEyrz6zdAGsWNVPBQN9LV/xvhNexBpAr?=
 =?us-ascii?Q?CAH0kCzGvqJ8IzCHuuBwqSR1FX/MyuuG6kGICrqvGZ4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07702242-56c9-491b-8a38-08dbefb2a5da
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 01:37:57.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46aQca1eeB7vz/ueJfV99DHSeqMPyCTHOn+d4PzPCRY+YqLFoZklm7QZZiIOUdyUYH5aJuJS+rl/teKrbxfDSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=733 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280011
X-Proofpoint-GUID: L-FRspAKFN35ZuZdUHdxH4VfftfeZHQW
X-Proofpoint-ORIG-GUID: L-FRspAKFN35ZuZdUHdxH4VfftfeZHQW

On Tue, Nov 28, 2023 at 11:16:06AM +1100, NeilBrown wrote:
> On Tue, 28 Nov 2023, Chuck Lever wrote:
> > On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> > > 
> > > I have evidence from a customer site of 256 nfsd threads adding files to
> > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > work-queue thread running delayed_fput().  As you might imagine this
> > > does not end well (20 million files in the queue at the time a snapshot
> > > was taken for analysis).
> > > 
> > > While this might point to a problem with the filesystem not handling the
> > > final close efficiently, such problems should only hurt throughput, not
> > > lead to memory exhaustion.
> > 
> > I have this patch queued for v6.8:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=c42661ffa58acfeaf73b932dec1e6f04ce8a98c0
> > 
> 
> Thanks....
> I think that change is good, but I don't think it addresses the problem
> mentioned in the description, and it is not directly relevant to the
> problem I saw ... though it is complicated.
> 
> The problem "workqueue ...  hogged cpu..." probably means that
> nfsd_file_dispose_list() needs a cond_resched() call in the loop.
> That will stop it from hogging the CPU whether it is tied to one CPU or
> free to roam.
> 
> Also that work is calling filp_close() which primarily calls
> filp_flush().
> It also calls fput() but that does minimal work.  If there is much work
> to do then that is offloaded to another work-item.  *That* is the
> workitem that I had problems with.
> 
> The problem I saw was with an older kernel which didn't have the nfsd
> file cache and so probably is calling filp_close more often.

Without the file cache, the filp_close() should be handled directly
by the nfsd thread handling the RPC, IIRC.


> So maybe
> my patch isn't so important now.  Particularly as nfsd now isn't closing
> most files in-task but instead offloads that to another task.  So the
> final fput will not be handled by the nfsd task either.
> 
> But I think there is room for improvement.  Gathering lots of files
> together into a list and closing them sequentially is not going to be as
> efficient as closing them in parallel.

I believe the file cache passes the filps to the work queue one at
a time, but I don't think there's anything that forces the work
queue to handle each flush/close completely before proceeding to the
next.

IOW there is some parallelism there already, especially now that
nfsd_filecache_wq is UNBOUND.


> > > For normal threads, the thread that closes the file also calls the
> > > final fput so there is natural rate limiting preventing excessive growth
> > > in the list of delayed fputs.  For kernel threads, and particularly for
> > > nfsd, delayed in the final fput do not impose any throttling to prevent
> > > the thread from closing more files.
> > 
> > I don't think we want to block nfsd threads waiting for files to
> > close. Won't that be a potential denial of service?
> 
> Not as much as the denial of service caused by memory exhaustion due to
> an indefinitely growing list of files waiting to be closed by a single
> thread of workqueue.

The cache garbage collector is single-threaded, but nfsd_filecache_wq
has a max_active setting of zero.


> I think it is perfectly reasonable that when handling an NFSv4 CLOSE,
> the nfsd thread should completely handle that request including all the
> flush and ->release etc.  If that causes any denial of service, then
> simple increase the number of nfsd threads.
> 
> For NFSv3 it is more complex.  On the kernel where I saw a problem the
> filp_close happen after each READ or WRITE (though I think the customer
> was using NFSv4...).  With the file cache there is no thread that is
> obviously responsible for the close.
> To get the sort of throttling that I think is need, we could possibly
> have each "nfsd_open" check if there are pending closes, and to wait for
> some small amount of progress.

Well nfsd_open() in particular appears to be used only for readdir.

But maybe nfsd_file_acquire() could wait briefly, in the garbage-
collected case, if the nfsd_net's disposal queue is long.


> But don't think it is reasonable for the nfsd threads to take none of
> the burden of closing files as that can result in imbalance.
> 
> I'll need to give this more thought.


-- 
Chuck Lever

