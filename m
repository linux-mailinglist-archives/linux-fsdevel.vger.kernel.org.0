Return-Path: <linux-fsdevel+bounces-5565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CE780DA4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E186B2173E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 19:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF21524B3;
	Mon, 11 Dec 2023 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S4VLVjPM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WSgXQEDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9846BB8;
	Mon, 11 Dec 2023 11:02:59 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBGtdDd025529;
	Mon, 11 Dec 2023 19:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=pOEp8qPCHDYXVBQzPCPvPXnDP5TGfnByWmqPOJprwtI=;
 b=S4VLVjPMAoZMM9U1JU+d2Op0BHLQbqoGIpB9Ewb/w15IQo9vgv9bLL5R4ZOKJO3V/zFe
 fIDOq3Du0j3019A/KfW3Cqz9gRINLfQswRyzT0qCpiYg6r4yMkZzaiLSpkg4LM8CQ99p
 hQ5r5TwMO55C2iFdZJUF51mUH4Cd4+8rh1J0VDW0E6TnvxkEy9AOiOJRBrMxuWKv2IjN
 7Oa5A/l2N1F8MVRCwNaMkg0+ceEshoK+2CdGWqQ4lM4AOczSfgnj2M094g7xtBM1dmjQ
 IoAYw0OJjzCVlhK0QKTANqg2b7LfVuRiKZRv5dwp1xGxNv+JeTEjb4LIFee27Ph+if7e aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5df0fp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 19:01:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBIu8W5009894;
	Mon, 11 Dec 2023 19:01:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep5d9sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 19:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA/5UTAtHzfJbY+ZMyNlu+88lE7djCXEJYkMnNVvmnFlbLF4O9cc8yrfjqpH8XXzYpxy1fFupQGSz2xhMaJ09pg2ggfJQLRmUREZU+IUZdfCqWa85E7WY6nV66dZ+qQJWbYBY1nd+Z36ltzHJaHzv1Mxll8ZFNki563shKCXEa9LRv/iwcU+VjpOnRlM7LLFRaPk8m+sH1l0nOs5R4aKoCgBrD+Uc0PRwd+CCUVcO6/1rAaWFYej8UqO5reWpQ67s/dfNh3hA9hTinHhM9d9L5AJyOzDU1lr3XAOOm40klN+RZ3+xsIBqMTN2jTEB57cJqFri8HUP1wuWn1OcNDGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOEp8qPCHDYXVBQzPCPvPXnDP5TGfnByWmqPOJprwtI=;
 b=H8yA0xddzB+QMLVxJBLYtVcRZjV/W/QesjBZDPJ40FYsIwJStMFmiCSpLyyi4EkL0xL0Yv2AsEOhRhUCFG6dJoGVyYLnyGsF0Qbiuq2+926jMUgTcK+P5UR3XTb/lcMWrNdkp4+k25Eq6n6mWDv9CmTenSx7Vjglee6VAzVLzKImn5F2NevV/aW/ZekWIdjzwQ5XU8S6iiMLYixGKw86v0eU8GhSPThlQFMGlKyLrULvBVd+RU6dWoM5oHsO1Gh0Twy4hIvxdy+RM8Ns8s1ySTRxKrUkP7qWJPyUTuzeLR3lZlL8lkQE3hv4xf94mSnHmIpcfV8AWKOLNuOTkjVMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOEp8qPCHDYXVBQzPCPvPXnDP5TGfnByWmqPOJprwtI=;
 b=WSgXQEDGvOGw96LIsIAI18EJwPDL8mU0ymp+CcWq5n+4UiGeGyKqS6qFMKMjq9B3Lt9ALhIb4br6CI9JMKAlxT0x6bXhwa/FxqnJgjOT6ekhzjC2D+YEk79n2UzMzGBE0Q+E7/kfFW6uG3zTjOKjbyLjMYdBpFAI1HZJ0+K7/KU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 19:01:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 19:01:43 +0000
Date: Mon, 11 Dec 2023 14:01:39 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Message-ID: <ZXdck2thv7tz1ee3@tissot.1015granger.net>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170224845504.12910.16483736613606611138@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: 835e61a3-45c4-4445-7cb0-08dbfa7b9d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gctjAaExz5B+uSO8jflRQjKNx72MOiKUQVLH/wTiMybwo149HNG2r5FGtKU9GxoQyHwB9ziiAx5JlVdLY+ofuV+5r/BjTTJWIofB2CituPOInEqL9oGRS3FRJWAJOaMInAYZKyyO4hHuSf2d2asWRBcUeEoMr646FQVSZ3PQ7230TpcMnRWP0w+9FkqzGHEUU8ad5kkrp93w+GvY9ePJEKj/Dxkz7o4NJJ3wOz1KMomTvyJ/XXsQGfaXltdwnnP/VfpTR7sgOGba8U2Fvc2xpXx7sMuBIyr7JOgDTEFZbSjg1zGALggotdTRjSJFTo9m0ZVMHoX8UQ2HV/XrXBcKqmU+tkzFfPMFjGeSHwNpiI33uihfIuyJJTRFfhJx3RBJ1Vpiwy2MGFq5n+X4TpmYy1YqR2LOdvBXs09uZrFkizkE29UZRQHOBAYYAK0y4tmGHJAhJIOaqMh28MMyGtp6ME8AHbJi9gS/fbU0eRqn2s7xfVpIkKCiVtSMj6UdD3AizH6T7iQF0u/xjJpVKlzO9Hbet4U+xsqbEtXoE1AyzfbjPmyuvtnpM7mAwFAOMh/j
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(38100700002)(2906002)(5660300002)(44832011)(316002)(4326008)(8936002)(8676002)(6916009)(54906003)(66946007)(66476007)(66556008)(9686003)(86362001)(6512007)(6666004)(478600001)(26005)(83380400001)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QMPMN7xaByzpzb4GSHnoPctFzVKGsmmwadj0wqj2RP7vO6tZAcrcaU3f/Nqt?=
 =?us-ascii?Q?caP9dY/BgQpxLt5qmM+YFwlPw+G2Q8Dfr+OTwJtXcEOVCxJDI4pQrRSH4i+J?=
 =?us-ascii?Q?Emw7uCPc+sZIL69er3Y/V+fXvbd56p7rhjgqIwMjA991AwPGWfvSgeYAo4Ff?=
 =?us-ascii?Q?6IWjYS3TvDyaCEwGQWdm88DXSuvX2ci/XClLNIh5ryLIeI8kBFt+Ly1gC5hb?=
 =?us-ascii?Q?RE/wwsUp3wJTHlUTM5iUnSz/lM6IIbIH2bARDYFe98VVWgrQF5v41X7S1GJO?=
 =?us-ascii?Q?mWwSyebISCYx/QQMMzPhD0y0BZP4WBpsLeeaZVCakkSjrsXkyWrBicrPPNfG?=
 =?us-ascii?Q?Yib4kXV+G9IsfaKIhfNKlvPzRjJHGm/58tZ9PGqccQlgAFxcU7qBnyvfLYwC?=
 =?us-ascii?Q?LoQDUnRE50T0vZo5iTKGBNhqLGNFv3QKzKUWkPxQaZuQWWSHwlFR166Plwsi?=
 =?us-ascii?Q?eZQe9vaI5szZuo3sdjLkWMCPU0uW8E0/Y/dzUEugmJs/cx+FESe4O2g6Prbu?=
 =?us-ascii?Q?3aueOh5VU/mQPukZ//+Imkxj4Ust7Pl8jHt1fDp3M+sPgLkmfH4IfHXNMSrP?=
 =?us-ascii?Q?KateAyPIR4pKOi9MeTs/hzOdAb05DfIu/VEO54xel1Vwg8VNcmqtEW+XOEwl?=
 =?us-ascii?Q?hG2V7IYt0COPCEcPDf76lKf8COedok8hBTUCrUZup+Uk/+slFMilVoScsjNI?=
 =?us-ascii?Q?hgSysQOqYeSLFJs1phY+N2zQyw5TSxO6S4nYmxC2EKgyrGk/kmYMw9uAVuhr?=
 =?us-ascii?Q?k3eSl07NezVtkiT0J0B9idf+LJRN+6B1z7OmiR/jN5/kahO19dCCgbUv/1LD?=
 =?us-ascii?Q?IjmsYRJmR+XnARXlKZKvAFPRLv2sl7tsndx6gP6oSlf+KkgOwcfPf2XpqK9U?=
 =?us-ascii?Q?zI7BnTnYbN7hr6+wQsNO1lKmSxjqWdumWH1RHIc0EOHqb356fjodK0GIq3zm?=
 =?us-ascii?Q?ozfuBBwnYLL9JpCIjlUtd9A0OXPWwcFskJzJhkdLkJjqPIM0kI3S0Aam2aY8?=
 =?us-ascii?Q?3L9QlVwYkKFWasNTjKERcQL1FrzZiSMeRscfQX6ZqTdPWNIVMFFsqSVwmHqJ?=
 =?us-ascii?Q?krDdtSoAi7Zq/bL1i0US35B7BeWM+OQQCBN0m+iAHqSxXWaaLld/PTSTsdaN?=
 =?us-ascii?Q?zA1EJMysN1YJpR/0krFGXpd1ssf8XwPd+TM9aBkhQdOPXME2j1IW6Je5cZk/?=
 =?us-ascii?Q?FUzIg/ZkEl9WFmeovqXq4JaL6wO3F9x7rGFBUjMEUKjyn4V7bjii6gfB34GW?=
 =?us-ascii?Q?nlkRmaXIyjKutBfgCxvQ/Wyr9chm3rIIoAXbVRsHZt/A2plhMFjtguGKyfDZ?=
 =?us-ascii?Q?tdjfvZruqkJDrEM+eeXka6E+y+eEt+vAcCVzTU05l6aZH6wQPXSrw5YfCoHk?=
 =?us-ascii?Q?775aFPTXLUog62I+E+9gEzUGuWzxePolQBgZ8titws8/2IbqYl90JXfMvP4y?=
 =?us-ascii?Q?YEnwfx9dCGfxU2S5Ln/9HMvSFvI1Le173eg7K9nvoeL5PyOSMPNbd6pvOIhH?=
 =?us-ascii?Q?D4w2FfHqIG/VfDnknTSyvw42lWfyPlPxPHKxOiayrcsFE3GktfaH6Ac1Hn76?=
 =?us-ascii?Q?jWKCD2qNOoro3a+ZJpjVeUs3bSLRFkr+7wDZlM42qcUKRwQTu8wFa6NQcL00?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2KlWMgot61FSu4i5FA1m65nopedxE68be95r4YVMXLbqic4Wq9/5epDFH8HamE2t3gRY92b3MXJGS/Npk8PEt8BFNXiLjiF5Eh54c4id9PjhSY92fcQMXzDJcShbJF8rWbtQV+J91nWxmyMaGQ3UcyM1f1KyvedR6C7nK6lCaZWDDgZp46dTnx0nwS4TBEwcaZw2f1wwa4ELKJbowuymfgZsc1jPkeOXm89qKRclIAY4kg5aNavjPESfj7nChlzFpy6bc77xTO+yhizYgOb1FmL+aUMxUodoOA+xyTwp/JDcaq1k1OdVDt7EvwAZjCSmR5/RiGSkhvm8QCTplvTEVBk1n5MFVL3EvpEpQnu5is+kRXreJnuV6aL0KhgHP2NN7D9/MNxQOdeLw16sSA/xw9hhRBBNSqDKPxRg3Wfyz58SIzTL8XAhSM47m280RcpLLtHLmbNGtkHr5sCarQLyEScUQXYponO3sOc5FgoEmJ0K/TX8+8hu7iYroM1lf0t0WZDSYd6GWWPYzz/UeQd9RgC5kbnD6URu8kLCDTXxe0mdxDcKkqNIUJ4sZFLHZTSONlrnBIoeR64+n60j4b/Yq2l1upmSEEi4uLVAHe0TnC1Ztocglmn9TafWa6DtBSk6t1bEutg/MlzcyIl0BaDXbZqVBBIrTzC0KS9OC43hHOOoqH+erBZx+d5Zl51y5EOZBRwoLT2E/OKenZsbkFZbePh/CXFL9aHBphy5Z8hrdMY02Yh18kkwj5LfOkddmYxF9eiOt5/4i3QXPDx+ROJXheQKTiSyUHneMn6RI4MOHXPT/qmi6frPu64eBO3vQNXgZ31fIMAxtTREW7R3yUX/XRXpi76Cze9cQqvoVcVwMOLKWEqkI677DSH8ymwSE5BHD4H+WsfaMGWpi3gEcjcxR7ywfYggfiWw2EDIfaxAPwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835e61a3-45c4-4445-7cb0-08dbfa7b9d58
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 19:01:43.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYcYEYB/yt/U9dNFu5gsP12u0KjJbbSWuBbzI60ei0iZfPojytwyvsPd1APMBZ+iajredL0waHRGTvQVGxIQTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_09,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=915 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312110157
X-Proofpoint-GUID: gt9jlqvPrFa191a54LsY-tAxlmrGRyMY
X-Proofpoint-ORIG-GUID: gt9jlqvPrFa191a54LsY-tAxlmrGRyMY

On Mon, Dec 11, 2023 at 09:47:35AM +1100, NeilBrown wrote:
> On Sat, 09 Dec 2023, Chuck Lever wrote:
> > On Fri, Dec 08, 2023 at 02:27:26PM +1100, NeilBrown wrote:
> > > Calling fput() directly or though filp_close() from a kernel thread like
> > > nfsd causes the final __fput() (if necessary) to be called from a
> > > workqueue.  This means that nfsd is not forced to wait for any work to
> > > complete.  If the ->release of ->destroy_inode function is slow for any
> > > reason, this can result in nfsd closing files more quickly than the
> > > workqueue can complete the close and the queue of pending closes can
> > > grow without bounces (30 million has been seen at one customer site,
> > > though this was in part due to a slowness in xfs which has since been
> > > fixed).
> > > 
> > > nfsd does not need this.
> > 
> > That is technically true, but IIUC, there is only one case where a
> > synchronous close matters for the backlog problem, and that's when
> > nfsd_file_free() is called from nfsd_file_put(). AFAICT all other
> > call sites (except rename) are error paths, so there aren't negative
> > consequences for the lack of synchronous wait there...
> 
> What you say is technically true but it isn't the way I see it.
> 
> Firstly I should clarify that __fput_sync() is *not* a flushing close as
> you describe it below.
> All it does, apart for some trivial book-keeping, is to call ->release
> and possibly ->destroy_inode immediately rather than shunting them off
> to another thread.
> Apparently ->release sometimes does something that can deadlock with
> some kernel threads or if some awkward locks are held, so the whole
> final __fput is delay by default.  But this does not apply to nfsd.
> Standard fput() is really the wrong interface for nfsd to use.  
> It should use __fput_sync() (which shouldn't have such a scary name).
> 
> The comment above flush_delayed_fput() seems to suggest that unmounting
> is a core issue.  Maybe the fact that __fput() can call
> dissolve_on_fput() is a reason why it is sometimes safer to leave the
> work to later.  But I don't see that applying to nfsd.
> 
> Of course a ->release function *could* do synchronous writes just like
> the XFS ->destroy_inode function used to do synchronous reads.

I had assumed ->release for NFS re-export would flush due to close-
to-open semantics. There seem to be numerous corner cases that
might result in pile-ups which would change the situation in your
problem statement but might not result in an overall improvement.


> I don't think we should ever try to hide that by putting it in
> a workqueue.  It's probably a bug and it is best if bugs are visible.


I'm not objecting, per se, to this change. I would simply like to
see a little more due diligence before moving forward until it is
clear how frequently ->release or ->destroy_inode will do I/O (or
"is slow for any reason" as you say above).


> Note that the XFS ->release function does call filemap_flush() in some
> cases, but that is an async flush, so __fput_sync doesn't wait for the
> flush to complete.

When Jeff was working on the file cache a year ago, I did some
performance analysis that shows even an async flush is costly when
there is a lot of dirty data in the file being closed. The VFS walks
through the whole file and starts I/O on every dirty page. This is
quite CPU intensive, and can take on the order of a millisecond
before the async flush request returns to its caller.

IME async flushes are not free.


> The way I see this patch is that fput() is the wrong interface for nfsd
> to use, __fput_sync is the right interface.  So we should change.  1
> patch.

The practical matter is I see this as a change with a greater than
zero risk, and we need to mitigate that risk. Or rather, as a
maintainer of NFSD, /I/ need to see that the risk is as minimal as
is practical.


> The details about exhausting memory explain a particular symptom that
> motivated the examination which revealed that nfsd was using the wrong
> interface.
> 
> If we have nfsd sometimes using fput() and sometimes __fput_sync, then
> we need to have clear rules for when to use which.  It is much easier to
> have a simple rule: always use __fput_sync().

I don't agree that we should just flop all these over and hope for
the best. In particular:

 - the changes in fs/nfsd/filecache.c appear to revert a bug
   fix, so I need to see data that shows that change doesn't
   cause a re-regression

 - the changes in fs/lockd/ can result in long waits while a
   global mutex is held (global as in all namespaces and all
   locked files on the server), so I need to see data that
   demonstrates there won't be a regression

 - the other changes don't appear to have motivation in terms
   of performance or behavior, and carry similar (if lesser)
   risks as the other two changes. My preferred solution to
   potential auditor confusion about the use of __fput_sync()
   in some places and fput() in others is to document, and
   leave call sites alone if there's no technical reason to
   change them at this time.

There is enough of a risk of regression that I need to see a clear
rationale for each hunk /and/ I need to see data that there is
no regression. I know that won't be perfect coverage, but it's
better than not having any data at all.


> I'm certainly happy to revise function documentation and provide
> wrapper functions if needed.
> 
> It might be good to have
> 
>   void filp_close_sync(struct file *f)
>   {
>        get_file(f);
>        filp_close(f);
>        __fput_sync(f);
>   }
> 
> but as that would only be called once, it was hard to motivate.
> Having it in linux/fs.h would be nice.
> 
> Similarly we could wrap __fput_sync() in a more friendly name, but
> that would be better if we actually renamed the function.
> 
>   void fput_now(struct file *f)
>   {
>       __fput_sync(f);
>   }
> 
> ??

Since this is an issue strictly for nfsd, the place for this
utility function is in fs/nfsd/vfs.c, IMO, along with a documenting
comment that provides a rationale for why nfsd does not want plain
fput() in specific cases.

When other subsystems need a similar capability, then let's
consider a common helper.


-- 
Chuck Lever

