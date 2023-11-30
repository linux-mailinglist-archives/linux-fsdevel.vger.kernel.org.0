Return-Path: <linux-fsdevel+bounces-4477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3052D7FF9EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531F21C20C2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77659175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DGrxsRKH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rGgcTXLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8510FC;
	Thu, 30 Nov 2023 10:08:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUHuS8O021766;
	Thu, 30 Nov 2023 18:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=UKZDbsVWTHGZDBjtzK+D4dn9V7LSrl1iUn9wx5nF/IA=;
 b=DGrxsRKHF6435lsL5i6sLdp202EM70Ri9FMwTQXljBTkwSJ8YnXQZBblgbLo9yH3YQFR
 Sw0TFGQAR9L7Gwoe6qY9Jt8La7WSdhleXoGz59C7gyasBNObrvrEgoZwnlyWJSxj6n+E
 OzRSgeIOn+4gnrJwyEDrxbx/FB9E2u5XecW4yYDKt/eaGbzhQr1Uns/q9FZ5JfySm8zR
 dWgiGoJuehjCOpJm+HJkRhRHjwT3UMBYEJcVL/pYPptXw9l6t7dIIA0w3vfEKRr2gusS
 +jKKzVRXrwcyVIV9A59WyAn5b7yjBTGj8VtugX8rqtOBA8fvZJhBd0tU8JfVKFb2zh/V aw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3upy7xg1hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 18:08:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AUH6TA3009600;
	Thu, 30 Nov 2023 18:08:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cafj8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 18:08:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcqI1J6lagqQ4mollwh7cZQN2FwjV1KkHw2v4+3qRIDF5iX+EfHPYp/IlYXzvQJDroJ0sMD+YwhSj1Xu4SkcIqVPfyPNLu5l0E5K3c0udXHwlfwDLEN1sUc0BAcOyCtJNUYlq75XepR0uPJQeXrY5M213n3xkqm+/Z/G0xLEpYSDzFmQGRRrcYyeHyGqXkme5NIYzSMqOJ8XRJdcVAZTVJTK+dwc7ujkk9/7leyBkHLB75a/+Uw9Xp5B5cUWcaqYaA2id9EWkOpKFVs3Rn89nJjhaR2X1jT3PzI0OM/LQkr3vN1lscNH3iGHy4tnGGgcnMW/9ISm8XZ7eIjgiK1QYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKZDbsVWTHGZDBjtzK+D4dn9V7LSrl1iUn9wx5nF/IA=;
 b=SiXWHlZQeMLh9Xt47VBB2XCmfNef7texFOwWOCwxTPzh+dPJ50OjG9dJZQfvg9Nhl4MpXp+8EfdZ2tlCZ/Q3Ab9rWDOehg4zpF6FU5pHnu0Tr61oXLvMv4WFOrFiU7aDe0iW5qnoJ6uzKp0gTPO8y3sfAYGHU50/e8XBLuo5eFygR6FGsocor2ini1Hzsv04lRJk5B4rNDZ8670V+u2+gFHysmx0eyhLQ699ds3Glg1xwJUkSGld2ExNEhF647bb3lJWnLHAXh4NCYSE3UFI3I9tGCBTxQtujmznysZk6xIvrDS6920a9CRm2frt1vOBcNjBvKfZFwzULMNZkV7ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKZDbsVWTHGZDBjtzK+D4dn9V7LSrl1iUn9wx5nF/IA=;
 b=rGgcTXLveFm8X6Ck3G61LC07qjIo3LGL2nKZoNhTOKJkCtDI+IYq9m+gabuQD3c6RgqaKThlqAM8nG2W75PaF9Vm+ybFL0jcduBmu1vsOzcSGedI15QGWCM8oaBPAsCn2PocA9EQdzMUx1GRU4GrDsfRzQswr0cWBxzA40v25TQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6357.namprd10.prod.outlook.com (2603:10b6:510:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 18:08:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 18:08:01 +0000
Date: Thu, 30 Nov 2023 13:07:57 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <ZWjPfZ9tuFXJP6us@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
 <170121362397.7109.17858114692838122621@noble.neil.brown.name>
 <ZWdE/7bNvxcsY3ae@tissot.1015granger.net>
 <2fd83daa77c6cf0825fd8ebc33f5dd2c5370bc5a.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd83daa77c6cf0825fd8ebc33f5dd2c5370bc5a.camel@kernel.org>
X-ClientProxiedBy: CH2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:610:51::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH8PR10MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 5269376d-62bd-4ac7-522e-08dbf1cf4a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EXNgr97NOiWm8PNdNuvLkQDYfzbu42FvXNo8xCr1qByuMSPGEJxJniQtFsXKetGjbnPcyDzVK8GKVmsJuQWE6vR32dgbqniU6SYFDxh9+tytMhDCleP7X/vcO275nY1ws6uu5TTT33X9x51h3huopqrvfIPvzr0Y27YjWlksGFPcRWmiC2I6HCD7JzpK/sN4JM/6Hq6S7mueCob9iAtul7aH2MCbxJGynsLNY2OrpXMnxiOgFpcBrElSPp6kusOaUGLIxSUF6xRI/16lrjtVbZdBpfAecbdX/Pd1gW1fJTfkhSuHmCF3KcZw70hpICRztEXJ5a+6oth5day4pWbtT4P74XZDEiIfFp0GD4q9wRQgFHZxSfaOETfBZ9WluutVyx6nUsZdME7Zu7u+E7gVYmKtSTofOhj2uF9B1FNF4pBYT8GnC7ZZPEl4xi5pWkmt8nJayZ3v8uQjFGc4pJ8tsaFuiVK7OuykBJjhqi0iN9tw5BTzgYuL63gIni7qY5Tq2/PA1/qDrhqgnky5z407VYczYvmgAkBXIofI8kZ7Ue4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(6666004)(6486002)(66476007)(8936002)(4326008)(8676002)(478600001)(38100700002)(316002)(66946007)(66556008)(86362001)(6916009)(26005)(6506007)(83380400001)(41300700001)(966005)(54906003)(6512007)(9686003)(44832011)(4001150100001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?26ipRPGeULmKFRaf0M1cbJG83xtuBZJFrJ3b+84b8YdF1pdoDSjXDlCOn7gt?=
 =?us-ascii?Q?KvceiPswKHHvUhjJR0G3oD8OMDCbdB50Ivq3UzjZ0bWyRKIGq5S3u0804xaC?=
 =?us-ascii?Q?/bpDE2nGv7Mz4vg4ugA3wXK3J21MqhQbWjdCjIjNtZHvRZ2YizVs5Z6LeLZi?=
 =?us-ascii?Q?juekdqNLQx+rGoeKGnJSu00fkv0pLhstlmv7UIvVZ7bX52GNPdnpuG7I8Trb?=
 =?us-ascii?Q?4a0Tivx8eoUH4bwxUIOkE9+Q10xeiYaNCVUZ/s7P5GCYch6SjRnvhy4xlgYX?=
 =?us-ascii?Q?Qs7e4uhNdXiMFw6fUA+O1yb5Sy+6etHk5NlOFfx03EOg9knmfaC5HAC4XL9j?=
 =?us-ascii?Q?z+pvI9z5hXjRnJBW4H64GqvaoWVyMt4JUwrtmi3JkT9iUXNchF6hpGxzzzz3?=
 =?us-ascii?Q?3j4s+9oSZfrGgQ9yODh9UVlUq0RBLZm6eZqOpq0dhfHQO//tlvxOuZsK+lAd?=
 =?us-ascii?Q?9QWRHIvehX30Mm4QiQopj/7laVWM1g3aXXn2XXbdwxgs7gnGmVvWcd93C7k8?=
 =?us-ascii?Q?FpU4mtJfsYSlDbi6Qx8BKEHIIlLtg+px+7hN/XHiJHnVNihPYA9ZKon6xMj7?=
 =?us-ascii?Q?r5HDhwA/DLEPLpAer8oRSOZKjJzQ2RDKjrII4TeMKIl85JokyxWo0Hl3pqXz?=
 =?us-ascii?Q?jyDo/cokXNIYikNGb8s0ymupN5SwI3CuEo8OmB3boyQWea+qYsTworvwyChN?=
 =?us-ascii?Q?6WJAve7jfhYm70fJg9KYV+tSGH3JnJ0enVDZU/919UouLDehut9xc9Dlue2H?=
 =?us-ascii?Q?Rf/Pywh5CE8ydxGZUCOCzsxtObG1NrExzOl2uoJt5uxkQ8S5hW0qWCaxbbbv?=
 =?us-ascii?Q?BA66Ppr9qBFuPbMafYEvutHD1eoNCT5p36r60XfxTxNILjQv6tKVtTE8U6w/?=
 =?us-ascii?Q?V91MbZZpwhVo1h1f3kQLb2q1j6sCN+nQwqEcQMwPF+rZD9hYFovJhQv3ss5w?=
 =?us-ascii?Q?JXy8Prk6xQW/fE/FWSBFgxLKbM3UEJy1VTvxg65Un+GnEgYPEzxAMqQRHI2Q?=
 =?us-ascii?Q?WLPFhfZhwOpsnn6RpyufT6OTpworfHOkH6VT+aMB6/iHsXxMB/9v84Nvm+u9?=
 =?us-ascii?Q?kiJV7VKGPm2kuAgeljdLBYQxXQ+97colsue3e4eVGdLT0dWJ/veZju20lWuW?=
 =?us-ascii?Q?HOkX8KFr6Qs6Mp34UGai9WsjIZZyv7KX6J9t77pXpEuo4+pjUQyLhifcdCg5?=
 =?us-ascii?Q?oYmkBCCFywyiEFd9vb9DbUljm8rIYIcjY6nswIGyJynyCIXH0r3DaweFm26P?=
 =?us-ascii?Q?D7T2jGCbX6khzdBCuRZy3QnD8g/Px3i/CwVJip+hdAWFjRPPOEJIAtJL3wNb?=
 =?us-ascii?Q?s344CPEugmIBMawVF3f4IHdn7Fn6V+1smbIcoX8cBJNd6tY8JpBHi+bnr5+a?=
 =?us-ascii?Q?12bWJb/dP822T6VhaenBCdYYF0OIbvCGWUrmq+mtc2wKLIQLPHDEps0SQAyA?=
 =?us-ascii?Q?6KGECVEq2JW2sYGN+mqNz8+4QiqVQsE3+eebSLgxjJqgsRrMwfhI8TH2oyI6?=
 =?us-ascii?Q?4n+BV8zc08NHFish7C2leh+4z0zo1UHvA+KQi6xHr5PGA5mE7/bkB+rE/QuP?=
 =?us-ascii?Q?fmN64CFAMx/WGfs2/qrXbFNBf3iKPKBfHQuduRd26ElibKEEG+5+tz7yDl+z?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1OIxoXGbf8VLyOLUN4S6uesQCgOWnTAV2GKUFFC44NfjNesuaN8qnXJW7XpAdjhPSHuFhsLFCTLQ+Z6khU2i/1qq2+7dWqZ+6rkA492rqMdwicZcBIXUM+P57qRZ7GQQFuqMnasONA5IuBoWMDOLIDH1+HeJuOBREIBIs6gB1/12ViSpP6fUB3H55nBHCAbVOPkJwh8sB3xqdLQnOIKckehvMB+Dhwe/7W1+9sV+hcprkohYfhU7m+zQ+EZRAg+yVAMgooa4VKOJMkZm5L4Y4d+RfRWwKtsf7KauEvXDij2wy2Iok60/Ah5RalaTvVl2WK9KpQ2izgK5GNf2XYlFiPpnbKl1JF9Tjftv7IbaO/gia8mCWIk4cxAonpWjDc3hnau924YCRHUoVYRrpht4WHR3OZUOGe4IpKOlK2Skuv17nqSikXx/OUqjVjRSlugDP+R0znZEX2FW1HyaA7pyC4FRvRJ26TQ8AdKG9wGgZVtgm8m8PZ2+t6rmg22nfEohh/z6ZUIZt0TDpmxuw5udrnvnqAgjZMPzd+IDS+fqUali9dZ9uxx5HVZ4wcJ8RfB81vjT3Fk0kMaCcVVY7MQChIexPs3ouJORLO4UnAR+Nm4quRS6kcI1JCbucdn8+J57IxE1UyryiaoVOZ6J7/4kJoHh0YNN/mmP9R8M09xd9GO6FfUFmGb4Gx/l1XHSNmdv2nozHigQ5onsYMchUWIYSGQSwXAzKAqGP1fropsPyD+DlNiLGky2ns5mfMvVz8eOW6NMCSNB17BmFAjsKAGOiW9sAqB3Qg7jnk65FbMlxJPfBol9E2c85RtkS+K5yF2QxKHsMkF8lqV0dBd/M5wL/lSIx9hdLj71XYYTqQd9OTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5269376d-62bd-4ac7-522e-08dbf1cf4a36
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:08:00.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEW84PjNaNtOqIJ4P6CMIVzkhEsqvZKEF/6/uwFNZa7kvT2+8uFde3clm/Pvgt5lri8viIp6zqHG23tT7dHqCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_17,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=685 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300134
X-Proofpoint-ORIG-GUID: E50JG-NyCNoSaK1BK41qXXttiRRtZmTV
X-Proofpoint-GUID: E50JG-NyCNoSaK1BK41qXXttiRRtZmTV

On Thu, Nov 30, 2023 at 12:47:58PM -0500, Jeff Layton wrote:
> On Wed, 2023-11-29 at 09:04 -0500, Chuck Lever wrote:
> > On Wed, Nov 29, 2023 at 10:20:23AM +1100, NeilBrown wrote:
> > > On Wed, 29 Nov 2023, Christian Brauner wrote:
> > > > [Reusing the trimmed Cc]
> > > > 
> > > > On Tue, Nov 28, 2023 at 11:16:06AM +1100, NeilBrown wrote:
> > > > > On Tue, 28 Nov 2023, Chuck Lever wrote:
> > > > > > On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> > > > > > > 
> > > > > > > I have evidence from a customer site of 256 nfsd threads adding files to
> > > > > > > delayed_fput_lists nearly twice as fast they are retired by a single
> > > > > > > work-queue thread running delayed_fput().  As you might imagine this
> > > > > > > does not end well (20 million files in the queue at the time a snapshot
> > > > > > > was taken for analysis).
> > > > > > > 
> > > > > > > While this might point to a problem with the filesystem not handling the
> > > > > > > final close efficiently, such problems should only hurt throughput, not
> > > > > > > lead to memory exhaustion.
> > > > > > 
> > > > > > I have this patch queued for v6.8:
> > > > > > 
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=c42661ffa58acfeaf73b932dec1e6f04ce8a98c0
> > > > > > 
> > > > > 
> > > > > Thanks....
> > > > > I think that change is good, but I don't think it addresses the problem
> > > > > mentioned in the description, and it is not directly relevant to the
> > > > > problem I saw ... though it is complicated.
> > > > > 
> > > > > The problem "workqueue ...  hogged cpu..." probably means that
> > > > > nfsd_file_dispose_list() needs a cond_resched() call in the loop.
> > > > > That will stop it from hogging the CPU whether it is tied to one CPU or
> > > > > free to roam.
> > > > > 
> > > > > Also that work is calling filp_close() which primarily calls
> > > > > filp_flush().
> > > > > It also calls fput() but that does minimal work.  If there is much work
> > > > > to do then that is offloaded to another work-item.  *That* is the
> > > > > workitem that I had problems with.
> > > > > 
> > > > > The problem I saw was with an older kernel which didn't have the nfsd
> > > > > file cache and so probably is calling filp_close more often.  So maybe
> > > > > my patch isn't so important now.  Particularly as nfsd now isn't closing
> > > > > most files in-task but instead offloads that to another task.  So the
> > > > > final fput will not be handled by the nfsd task either.
> > > > > 
> > > > > But I think there is room for improvement.  Gathering lots of files
> > > > > together into a list and closing them sequentially is not going to be as
> > > > > efficient as closing them in parallel.
> > > > > 
> > > > > > 
> > > > > > > For normal threads, the thread that closes the file also calls the
> > > > > > > final fput so there is natural rate limiting preventing excessive growth
> > > > > > > in the list of delayed fputs.  For kernel threads, and particularly for
> > > > > > > nfsd, delayed in the final fput do not impose any throttling to prevent
> > > > > > > the thread from closing more files.
> > > > > > 
> > > > > > I don't think we want to block nfsd threads waiting for files to
> > > > > > close. Won't that be a potential denial of service?
> > > > > 
> > > > > Not as much as the denial of service caused by memory exhaustion due to
> > > > > an indefinitely growing list of files waiting to be closed by a single
> > > > > thread of workqueue.
> > > > 
> > > > It seems less likely that you run into memory exhausting than a DOS
> > > > because nfsd() is busy closing fds. Especially because you default to
> > > > single nfsd thread afaict.
> > > 
> > > An nfsd thread would not end up being busy closing fds any more than it
> > > can already be busy reading data or busy syncing out changes or busying
> > > renaming a file.
> > > Which it is say: of course it can be busy doing this, but doing this sort
> > > of thing is its whole purpose in life.
> > > 
> > > If an nfsd thread only completes the close that it initiated the close
> > > on (which is what I am currently proposing) then there would be at most
> > > one, or maybe 2, fds to close after handling each request.
> > 
> > Closing files more aggressively would seem to entirely defeat the
> > purpose of the file cache, which is to avoid the overhead of opens
> > and closes on frequently-used files.
> > 
> > And usually Linux prefers to let the workload consume as many free
> > resources as possible before it applies back pressure or cache
> > eviction.
> > 
> > IMO the first step should be removing head-of-queue blocking from
> > the file cache's background closing mechanism. That might be enough
> > to avoid forming a backlog in most cases.
> 
> That's not quite what task_work does. Neil's patch wouldn't result in
> closes happening more aggressively. It would just make it so that we
> don't queue the delayed part of the fput process to a workqueue like we
> do today.
> 
> Instead, the nfsd threads would have to clean that part up themselves,
> like syscalls do before returning to userland. I think that idea makes
> sense overall since that mirrors what we already do in userland.
> 
> In the event that all of the nfsd threads are tied up in slow task_work
> jobs...tough luck. That at least makes it more of a self-limiting
> problem since RPCs will start being queueing, rather than allowing dead
> files to just pile onto the list.

Thanks for helping me understand the proposal. task_work would cause
nfsd threads to wait for flush/close operations that others have
already started; it would not increase the rate of closing cached
file descriptors.

The thing that nfsd_filesystem_wq does is compartmentalize the
flush/close workload so that a heavy flush/close workload in one
net namespace does not negatively impact other namespaces. IIUC,
then, task_work does not discriminate between namespaces -- if one
namespace is creating a backlog of dirty files to close, all nfsd
threads would need to handle that backlog, and thus all namespaces
would bear (a part of) that backlog.


-- 
Chuck Lever

