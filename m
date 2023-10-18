Return-Path: <linux-fsdevel+bounces-662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC357CE0FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE149B21239
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42E38BCE;
	Wed, 18 Oct 2023 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3ScOyXbB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wGCFVXJD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F920307
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:19:42 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50EE94;
	Wed, 18 Oct 2023 08:19:39 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IEiTwq001359;
	Wed, 18 Oct 2023 15:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=cfkxhOKRPNfO/3F+CYmEprQxYPbjdH4apDZ6Zy420TI=;
 b=3ScOyXbBUu5ebdIUksbsiaIdc+aUr1IaixWaDYnivP3EjQOKzfkA8lofxZs0HGdK9axE
 kEgF91dz6aMDay999lEH2kNZhL0LVqCRoQL39Y9AH71n7lLAc0h6OjAs3QdzWNeWEqG8
 CoLcwmoe6kQRuatJdbFL5GBv5roQULrUPLckyRlp4r9KAF2XxxSrwbD/Vfr9fWjmpbm+
 RZWe8IUKAPWWM5rQaBvhL3H2kmLa8mnTT6pE0kK5SM6BsKy945ah7rUXv6REjIAyPudC
 ujYnLvefeQvBppYyd2xqdVO3iQ/pl46VfGIKeoDPeL8QP/fEPkePRMnSYQGnto7aXaCA qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1fse0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 15:18:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IDs3t3015243;
	Wed, 18 Oct 2023 15:18:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1gmtgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Oct 2023 15:18:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAbLjNBZZDGpvBXzMVx0wf7x0q5wCZQi7/nClKrKoUeC4MGv5b9GfUx1jXYohmL3d9w62eGr0Do6Tci3S9IdR3Q8nCpQGlJ7/jOWfTB4FWIeqtXQ6uhGtf9FH3GcMXqQY3ZCeOgSkUMqRjMJCzv2D4RFE2NBoKVoeVsw0GOtIG3OGuVRFPIhfCMG27bUKCMoN7XnHlXfVvAAH7K51KEGLJ3S2fx5Q7XuLaD5YhVzyaYRzXpH2Zj3RTeCEaWOsOwNj8bMP71HgUOijC4Uecsdm6hUFPFPCZ3JSJMwInqVyJpBcF6dNIohj40X1ynSihCIc9MhGpCaLZvLGvSUL6U9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfkxhOKRPNfO/3F+CYmEprQxYPbjdH4apDZ6Zy420TI=;
 b=NAdnRd2YYvy7KUXNVf6XO6gBX8vUTC3SsNHWIcdV+LYJWyBOBbNFKBbi5shhT+GF7lhigajdmiZhZju0qSl2GAvMh2SjUjj6sGk/CvKylTZndRaCTOY4lyLVl1iQG0f56tezmc9ECzvwCZ6WfkMr+WiWeSp5+OhY9axl+a9GlbmrZy3iQubiScD4SbOlPy/ai8OYqotHP23J38o3KLQu22BpVsekKSOyDx+LG9yTdqyn0itUJkcebSRnUK8C/8x6U3Grpz+dlFnnso36+m78whLfkux5QkW0mcYeEkAG3nKMIxbeoxi/g9bMY094r53NUpz6UlB1houk5b9gfCi+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfkxhOKRPNfO/3F+CYmEprQxYPbjdH4apDZ6Zy420TI=;
 b=wGCFVXJDUXhRFPPIHkJ01fEqPf88TTSQTeOSokIowHbEEtA6c+lCIbEkZm3QAY/4Slw8hVHnsX0VPXNQAYr5rXOZsarka6uhrGOhi68/yFTEwjBGxWdbPCT3cwUWSWmvVMBXvcO3ia4mW3MHXut8cY/NyPS1YbsBK09QEBEhsTA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 15:18:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::215d:3058:19a6:ed3%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 15:18:44 +0000
Date: Wed, 18 Oct 2023 11:18:41 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Steve French <sfrench@samba.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for
 NFS export
Message-ID: <ZS/3UfX/+hH6xKMn@tissot.1015granger.net>
References: <20231018100000.2453965-1-amir73il@gmail.com>
 <20231018100000.2453965-4-amir73il@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018100000.2453965-4-amir73il@gmail.com>
X-ClientProxiedBy: CH2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:610:4c::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN0PR10MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: f1348cd3-de36-43af-f81c-08dbcfed84c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IsSUS8Gf+6QjX4yHCRoO+VYiSN6UkvEX3H3cCUyba1nNt2gCw2VW9NXvQ3jmdSx3l+4AS1O6rvVsuy8tCN/m5uWEFsOg7e8x3sHZyPo/TyB7Omsut395fpQH1ukk2Jk8NibmtBthGfvve01cZKkLplS5tEto0FQW7tkH8zKHSf1JqBGJlt2oaCx+Y9Ty7mhEkd2VR4wRVziIAAVfefzkhox990InUHlns5k8VRLHY+hFm8NYvZqN1T5utw/mc1MxiVRNnTMKzl3TUd603SUfmpA4s+AdyC12pnzSrpCOhYHu3kNxn7GM5p896FfUeaawOaTwKLd5buWU8exY1+OAWnDt5uLnwlBgbdpnH9nKB+tyPyys6IpSnGQtBP4Xp18eO4O0HJknefotC0+fi0iiC/WoGYledN0YsaaCQCkT6DaeYC9HEgsrpCcz8aKgULvrATRUVD2OztZv3CpxV3dIBovfLd0Irp33FiyHC0oSz1f7YozNroiqEGVbj2zai6KU5u9CZc+rWDBq6HyvVh2VLwBs2AcaF+5BZePTliFFDO6Q7vLlfh/DQHCE2wuGD4TS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(9686003)(6666004)(6512007)(6506007)(83380400001)(30864003)(5660300002)(8676002)(8936002)(4326008)(44832011)(41300700001)(7416002)(2906002)(6486002)(316002)(6916009)(478600001)(66476007)(66946007)(66556008)(54906003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Juqwd14OKbvU48fNoEQ2wAr4UAt+cikfZzYCt++eMud8t0DHEe8ClEbBdqEx?=
 =?us-ascii?Q?BH+D/eQK3IsbdeF/BAuuWuEPlUzoIeHF+DL8yDQQ7suiITK0pDn8NqsYc1Dd?=
 =?us-ascii?Q?XVJdgEmBDQrldFJs5WcsKAae5x9KgTXGZxMaR2EJmYgq5u/v38pFTgVX40PI?=
 =?us-ascii?Q?s3UKxyddLIp4VBQvzm5LmvVmkbKQy12SdP2IML5W7webLb3fG3sNinVIdfuP?=
 =?us-ascii?Q?zCgDDR3VcTzoLAARbaEuhqB/oddDZyHFljmPM7146Ms+X1XwTggVauyISG/m?=
 =?us-ascii?Q?WCoETjOCk673CADpUWOsNSnJmJJG2TaU7/1VNFJaV/JCp7wS+e/9sjTmX6k4?=
 =?us-ascii?Q?y3mTxofMDG1Obf6XJDhlnnYsEr+onLVMoNCvUXfnIA/uxk7bgipSZc27Q/GT?=
 =?us-ascii?Q?sVfDV813yqd/TJfwOTCpjA8vdJoMVwuFl9GX/IW0WuKyYWozOTWxORmK3/1U?=
 =?us-ascii?Q?g5DdQIVqxre0hxx28KfCc80ZJixE7Bkec4SiVwFQ7180qEeBDYVh+vjR+38g?=
 =?us-ascii?Q?zJxGNArPvH36ASuImNFXTsuDdGCTBJn+VYd1kpCSaDYOHeug4wz1vbGyq6xT?=
 =?us-ascii?Q?Bd2GPBeZzihJPsQlo+i8FXEI12JimQrw0xY3/eT/GiaKv7PqB2zP+I+scxM3?=
 =?us-ascii?Q?uFGoLnJLSELCp22kD7VwFkALGeUvTiGUvoztMGNjr0CKSRVFuGWWfxsSyOjN?=
 =?us-ascii?Q?EokrNgA2F2qUeoM6vxVV4NV060yR8pwVIyiKEhrHGc6GdyvetIx+6DYwTsaW?=
 =?us-ascii?Q?Kz+rdfJOhC+0Y+7DzqQs9KzUdGzIkMmSi+n/laFP8SaM64YS2SxdYhc6NWEi?=
 =?us-ascii?Q?jHcalZhMnW0CmZFHFNA9+MF9XER0Zfz/TzaUEKKnQuVVrq8q4FKyfC8V1Eel?=
 =?us-ascii?Q?O0gRhRf4eysxxHVWasb3esmHx9q8nbOdkw/RasYVoiEiGEm90ogbtZvPgrr2?=
 =?us-ascii?Q?YtYudkoA8ozcBCQBKIYEsz/lJ4OUkhMEkRetrtB4GamVMQTUwYF9zMsuYcp/?=
 =?us-ascii?Q?1KsuZaGuspoldiPXSTq/pUidsMCBOvgnLeFH7XM6AJbtajuqgxHO7ZieOgY2?=
 =?us-ascii?Q?c3Hmm4csKZWZetah3iRGxxXvNK56q6OOAWA1+SC/DJMMWGLYlbddeQUiMMkA?=
 =?us-ascii?Q?l0LxKfMwCDs6XQgVVXpQSKSPKqcWZdb7ERgUYnRcOt1m5B6QbvJzGnbFNRHv?=
 =?us-ascii?Q?vxZiHGe3NU4hVUbejiNjSJjJYGR7SMSA4HKYxZYMf5w36h/eykC0jX2utxZL?=
 =?us-ascii?Q?YS2SEIB13W3ss0mLG0o5+gkthQ/5XnvAzRsq9JyV6aypp2bOAAitp9nyka33?=
 =?us-ascii?Q?cWHgpAZX0TYNhRXPoauA/grM+YmkPc0QlTbzPVO37r2vkDQtS25NWyhusyCI?=
 =?us-ascii?Q?QFaB7heTmKr+fjNt3eENZDVtEI55p8krsXrpVKqvVQas3KqrxGnLSrHvV1CS?=
 =?us-ascii?Q?+xJCeYrovIx0GsdjsxpYGMTfNJpytAwUjJT+Z+ZMyBLAxVFIZBm1OSz0duBZ?=
 =?us-ascii?Q?OvvwnwHsw5Ixv3xhPJMSF3yxsGMG/mDV4a7cD8azk4pYad0fzZQMS5rUiSdw?=
 =?us-ascii?Q?oGIEYwD2JgoeorpulLILtN4crlWyfKf84k8IyfI9GNSn2IqV25UI4+9DgUBg?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?asUsIoMsXU/QsJ7036wP/2T9mNS/3eJ7MqQWO+2O97kcgMuTgVVSOtCjIhkE?=
 =?us-ascii?Q?AUQL02Xo2ONdK22e/Q0qRjQWEDeXDzTxco8jpMcICm89ZKkv2UlK/RnVpVf5?=
 =?us-ascii?Q?qxrTO83lYMc/rlZn4cizVfUkFRViQpv+GfBOJC5bEbI6B+oFTNRYBCKLBq95?=
 =?us-ascii?Q?5K2I9HMy0d4ea6rZ0tmaED62rmp1G3ba6eX0fcqGMdB+clMv/w63oLxCYHhP?=
 =?us-ascii?Q?zFHePt1oktrMVwVxPQ7S1CUFfWDl3zP4xAnI0j0djYXJFvmaPTG1nVOXjJwV?=
 =?us-ascii?Q?LleS6d+wTFHzCAi4L498B1b3XgQwKyTvef2T45TccgxpLTVKQGC2R4AvjxLC?=
 =?us-ascii?Q?P4lMZkwNNE+HvIdoNB6Bfaco3RZWO5iTVDF6ZjqAkzbOfa4oLuSv0yMiuRs3?=
 =?us-ascii?Q?9gptCu6i64GJaNWlqg//4bjPQ3oE+rKLybUF7FlugruZ93LO+wyWGbdeudq9?=
 =?us-ascii?Q?J8yOOIPOijDpVt2pKRTS4NX18a9U0+7nHvulF2uWcxFUs/ERv/y8GEx34GwA?=
 =?us-ascii?Q?IuJi5h4e70qs7Lz521EFXmtIpAidQhgfWfSif1+N8thAFsmRWJlaX4S7eZRY?=
 =?us-ascii?Q?9DLvPNKoz8yVMsg+UoK1rABinxyuPXOPXyNoE/pt3y35AbA3pq0yVs3E3TZP?=
 =?us-ascii?Q?7QNi+wMnxmutJRR3Fwo/TEpy1MqhyFh9BZxopzfPxFet9JsGmZsKDJZWCmDA?=
 =?us-ascii?Q?Da3fksVhfmCR4VWtz4Sjgk6QtY2e7xKRJLcXOKwMmj/SZS70WVFufOvv1iKo?=
 =?us-ascii?Q?Lw9G71D0sKrbXOGJbPzsFkbz4nkZEIvHrNeJfHl4/1EqNdDSOnlov4L4ERhB?=
 =?us-ascii?Q?bOpyVK/5b9TU8pwupWiS5TnZTUSISRCtmW3XjZcr18QjkGwzSVAtqKhMYkUx?=
 =?us-ascii?Q?2/3NmSCpc9bK2iPg80GVWO15mZRirzYrHfLXuw3F4yGXf+5p1lLvPKUbHIQO?=
 =?us-ascii?Q?kJkthpCwD1du+IMShj5lVayvMWoFcisFgh/v8EbYatXSSdWr77um9tr0+EVe?=
 =?us-ascii?Q?4i6ur/LAURsJ8cz/qbZXfIReIJ/BOqOukxg07yOyZFDIFGNrEaWAsFUk5xrP?=
 =?us-ascii?Q?iJQGzhtr4vVir+X5+8S3NQvSoedpxa5cxysd0v5KxwNWHfHwQDWp+2zdir8b?=
 =?us-ascii?Q?DKRpJ85wvzyrx8ieQcKOWfzNFoa5BNh4MQYPEAmJEkPJaM7YDABVqwSZWWus?=
 =?us-ascii?Q?mLX2CNBcFw4cGdyL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1348cd3-de36-43af-f81c-08dbcfed84c3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:18:44.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULW0RkeylwQQjuvXa+RUScabKM4NAH2DnADecZIDZ9qQMIxG60Ju7awZi65H8lxKeJ6Lsrjf6eYAWMCDX6kfYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_13,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180124
X-Proofpoint-GUID: YLLpsCfDU7Hw2x9eimKZCg-9i5YDeHyM
X-Proofpoint-ORIG-GUID: YLLpsCfDU7Hw2x9eimKZCg-9i5YDeHyM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 12:59:58PM +0300, Amir Goldstein wrote:
> export_operations ->encode_fh() no longer has a default implementation to
> encode FILEID_INO32_GEN* file handles.
> 
> Rename the default helper for encoding FILEID_INO32_GEN* file handles to
> generic_encode_ino32_fh() and convert the filesystems that used the
> default implementation to use the generic helper explicitly.
> 
> This is a step towards allowing filesystems to encode non-decodeable file
> handles for fanotify without having to implement any export_operations.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/nfs/exporting.rst |  7 ++-----
>  Documentation/filesystems/porting.rst       |  9 +++++++++
>  fs/affs/namei.c                             |  1 +
>  fs/befs/linuxvfs.c                          |  1 +
>  fs/efs/super.c                              |  1 +
>  fs/erofs/super.c                            |  1 +
>  fs/exportfs/expfs.c                         | 14 ++++++++------
>  fs/ext2/super.c                             |  1 +
>  fs/ext4/super.c                             |  1 +
>  fs/f2fs/super.c                             |  1 +
>  fs/fat/nfs.c                                |  1 +
>  fs/jffs2/super.c                            |  1 +
>  fs/jfs/super.c                              |  1 +
>  fs/ntfs/namei.c                             |  1 +
>  fs/ntfs3/super.c                            |  1 +
>  fs/smb/client/export.c                      |  9 +++------
>  fs/squashfs/export.c                        |  1 +
>  fs/ufs/super.c                              |  1 +
>  include/linux/exportfs.h                    |  4 +++-
>  19 files changed, 39 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
> index 4b30daee399a..de64d2d002a2 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -122,12 +122,9 @@ are exportable by setting the s_export_op field in the struct
>  super_block.  This field must point to a "struct export_operations"
>  struct which has the following members:
>  
> -  encode_fh (optional)
> +  encode_fh (mandatory)
>      Takes a dentry and creates a filehandle fragment which may later be used
> -    to find or create a dentry for the same object.  The default
> -    implementation creates a filehandle fragment that encodes a 32bit inode
> -    and generation number for the inode encoded, and if necessary the
> -    same information for the parent.
> +    to find or create a dentry for the same object.
>  
>    fh_to_dentry (mandatory)
>      Given a filehandle fragment, this should find the implied object and
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index 4d05b9862451..197ef78a5014 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1045,3 +1045,12 @@ filesystem type is now moved to a later point when the devices are closed:
>  As this is a VFS level change it has no practical consequences for filesystems
>  other than that all of them must use one of the provided kill_litter_super(),
>  kill_anon_super(), or kill_block_super() helpers.
> +
> +---
> +
> +**mandatory**
> +
> +export_operations ->encode_fh() no longer has a default implementation to
> +encode FILEID_INO32_GEN* file handles.
> +Fillesystems that used the default implementation may use the generic helper
> +generic_encode_ino32_fh() explicitly.
> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> index 2fe4a5832fcf..d6b9758ee23d 100644
> --- a/fs/affs/namei.c
> +++ b/fs/affs/namei.c
> @@ -568,6 +568,7 @@ static struct dentry *affs_fh_to_parent(struct super_block *sb, struct fid *fid,
>  }
>  
>  const struct export_operations affs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.fh_to_dentry = affs_fh_to_dentry,
>  	.fh_to_parent = affs_fh_to_parent,
>  	.get_parent = affs_get_parent,
> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
> index 9a16a51fbb88..410dcaffd5ab 100644
> --- a/fs/befs/linuxvfs.c
> +++ b/fs/befs/linuxvfs.c
> @@ -96,6 +96,7 @@ static const struct address_space_operations befs_symlink_aops = {
>  };
>  
>  static const struct export_operations befs_export_operations = {
> +	.encode_fh	= generic_encode_ino32_fh,
>  	.fh_to_dentry	= befs_fh_to_dentry,
>  	.fh_to_parent	= befs_fh_to_parent,
>  	.get_parent	= befs_get_parent,
> diff --git a/fs/efs/super.c b/fs/efs/super.c
> index b287f47c165b..f17fdac76b2e 100644
> --- a/fs/efs/super.c
> +++ b/fs/efs/super.c
> @@ -123,6 +123,7 @@ static const struct super_operations efs_superblock_operations = {
>  };
>  
>  static const struct export_operations efs_export_ops = {
> +	.encode_fh	= generic_encode_ino32_fh,
>  	.fh_to_dentry	= efs_fh_to_dentry,
>  	.fh_to_parent	= efs_fh_to_parent,
>  	.get_parent	= efs_get_parent,
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3700af9ee173..edbe07a24156 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -626,6 +626,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
>  }
>  
>  static const struct export_operations erofs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.fh_to_dentry = erofs_fh_to_dentry,
>  	.fh_to_parent = erofs_fh_to_parent,
>  	.get_parent = erofs_get_parent,
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 9ee205df8fa7..30da4539e257 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -343,20 +343,21 @@ static int get_name(const struct path *path, char *name, struct dentry *child)
>  }
>  
>  /**
> - * export_encode_fh - default export_operations->encode_fh function
> + * generic_encode_ino32_fh - generic export_operations->encode_fh function
>   * @inode:   the object to encode
> - * @fid:     where to store the file handle fragment
> + * @fh:      where to store the file handle fragment
>   * @max_len: maximum length to store there
>   * @parent:  parent directory inode, if wanted
>   *
> - * This default encode_fh function assumes that the 32 inode number
> + * This generic encode_fh function assumes that the 32 inode number
>   * is suitable for locating an inode, and that the generation number
>   * can be used to check that it is still valid.  It places them in the
>   * filehandle fragment where export_decode_fh expects to find them.
>   */
> -static int export_encode_fh(struct inode *inode, struct fid *fid,
> -		int *max_len, struct inode *parent)
> +int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
> +			    struct inode *parent)
>  {
> +	struct fid *fid = (void *)fh;
>  	int len = *max_len;
>  	int type = FILEID_INO32_GEN;
>  
> @@ -380,6 +381,7 @@ static int export_encode_fh(struct inode *inode, struct fid *fid,
>  	*max_len = len;
>  	return type;
>  }
> +EXPORT_SYMBOL_GPL(generic_encode_ino32_fh);
>  
>  /**
>   * exportfs_encode_inode_fh - encode a file handle from inode
> @@ -402,7 +404,7 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  	if (nop && nop->encode_fh)
>  		return nop->encode_fh(inode, fid->raw, max_len, parent);
>  
> -	return export_encode_fh(inode, fid, max_len, parent);
> +	return -EOPNOTSUPP;
>  }
>  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
>  
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index aaf3e3e88cb2..b9f158a34997 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -397,6 +397,7 @@ static struct dentry *ext2_fh_to_parent(struct super_block *sb, struct fid *fid,
>  }
>  
>  static const struct export_operations ext2_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.fh_to_dentry = ext2_fh_to_dentry,
>  	.fh_to_parent = ext2_fh_to_parent,
>  	.get_parent = ext2_get_parent,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dbebd8b3127e..c44db1915437 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1646,6 +1646,7 @@ static const struct super_operations ext4_sops = {
>  };
>  
>  static const struct export_operations ext4_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.fh_to_dentry = ext4_fh_to_dentry,
>  	.fh_to_parent = ext4_fh_to_parent,
>  	.get_parent = ext4_get_parent,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a8c8232852bb..60cfa11f65bf 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3282,6 +3282,7 @@ static struct dentry *f2fs_fh_to_parent(struct super_block *sb, struct fid *fid,
>  }
>  
>  static const struct export_operations f2fs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.fh_to_dentry = f2fs_fh_to_dentry,
>  	.fh_to_parent = f2fs_fh_to_parent,
>  	.get_parent = f2fs_get_parent,
> diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
> index 3626eb585a98..c52e63e10d35 100644
> --- a/fs/fat/nfs.c
> +++ b/fs/fat/nfs.c
> @@ -279,6 +279,7 @@ static struct dentry *fat_get_parent(struct dentry *child_dir)
>  }
>  
>  const struct export_operations fat_export_ops = {
> +	.encode_fh	= generic_encode_ino32_fh,
>  	.fh_to_dentry   = fat_fh_to_dentry,
>  	.fh_to_parent   = fat_fh_to_parent,
>  	.get_parent     = fat_get_parent,
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index 7ea37f49f1e1..f99591a634b4 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -150,6 +150,7 @@ static struct dentry *jffs2_get_parent(struct dentry *child)
>  }
>  
>  static const struct export_operations jffs2_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.get_parent = jffs2_get_parent,
>  	.fh_to_dentry = jffs2_fh_to_dentry,
>  	.fh_to_parent = jffs2_fh_to_parent,
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index 2e2f7f6d36a0..2cc2632f3c47 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -896,6 +896,7 @@ static const struct super_operations jfs_super_operations = {
>  };
>  
>  static const struct export_operations jfs_export_operations = {
> +	.encode_fh	= generic_encode_ino32_fh,
>  	.fh_to_dentry	= jfs_fh_to_dentry,
>  	.fh_to_parent	= jfs_fh_to_parent,
>  	.get_parent	= jfs_get_parent,
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index ab44f2db533b..d7498ddc4a72 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -384,6 +384,7 @@ static struct dentry *ntfs_fh_to_parent(struct super_block *sb, struct fid *fid,
>   * and due to using iget() whereas NTFS needs ntfs_iget().
>   */
>  const struct export_operations ntfs_export_ops = {
> +	.encode_fh	= generic_encode_ino32_fh,
>  	.get_parent	= ntfs_get_parent,	/* Find the parent of a given
>  						   directory. */
>  	.fh_to_dentry	= ntfs_fh_to_dentry,
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 5661a363005e..661ffb5aa1e0 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -789,6 +789,7 @@ static int ntfs_nfs_commit_metadata(struct inode *inode)
>  }
>  
>  static const struct export_operations ntfs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.fh_to_dentry = ntfs_fh_to_dentry,
>  	.fh_to_parent = ntfs_fh_to_parent,
>  	.get_parent = ntfs3_get_parent,
> diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
> index 37c28415df1e..834e9c9197b4 100644
> --- a/fs/smb/client/export.c
> +++ b/fs/smb/client/export.c
> @@ -41,13 +41,10 @@ static struct dentry *cifs_get_parent(struct dentry *dentry)
>  }
>  
>  const struct export_operations cifs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.get_parent = cifs_get_parent,
> -/*	Following five export operations are unneeded so far and can default:
> -	.get_dentry =
> -	.get_name =
> -	.find_exported_dentry =
> -	.decode_fh =
> -	.encode_fs =  */
> +/*	Following export operations are mandatory for NFS export support:
> +	.fh_to_dentry = */
>  };
>  
>  #endif /* CONFIG_CIFS_NFSD_EXPORT */
> diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
> index 723763746238..62972f0ff868 100644
> --- a/fs/squashfs/export.c
> +++ b/fs/squashfs/export.c
> @@ -173,6 +173,7 @@ __le64 *squashfs_read_inode_lookup_table(struct super_block *sb,
>  
>  
>  const struct export_operations squashfs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.fh_to_dentry = squashfs_fh_to_dentry,
>  	.fh_to_parent = squashfs_fh_to_parent,
>  	.get_parent = squashfs_get_parent
> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
> index 23377c1baed9..a480810cd4e3 100644
> --- a/fs/ufs/super.c
> +++ b/fs/ufs/super.c
> @@ -137,6 +137,7 @@ static struct dentry *ufs_get_parent(struct dentry *child)
>  }
>  
>  static const struct export_operations ufs_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
>  	.fh_to_dentry	= ufs_fh_to_dentry,
>  	.fh_to_parent	= ufs_fh_to_parent,
>  	.get_parent	= ufs_get_parent,
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 5b3c9f30b422..6b6e01321405 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -235,7 +235,7 @@ extern int exportfs_encode_fh(struct dentry *dentry, struct fid *fid,
>  
>  static inline bool exportfs_can_encode_fid(const struct export_operations *nop)
>  {
> -	return nop;
> +	return nop && nop->encode_fh;

The ->encode_fh() method returns an integer type, not a boolean. It
would be more clear if this were written

	return nop && (nop->encode_fh != FILEID_ROOT);

(I'm just guessing at what you might have intended).


>  }
>  
>  static inline bool exportfs_can_decode_fh(const struct export_operations *nop)
> @@ -279,6 +279,8 @@ extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
>  /*
>   * Generic helpers for filesystems.
>   */
> +int generic_encode_ino32_fh(struct inode *inode, __u32 *fh, int *max_len,
> +			    struct inode *parent);
>  extern struct dentry *generic_fh_to_dentry(struct super_block *sb,
>  	struct fid *fid, int fh_len, int fh_type,
>  	struct inode *(*get_inode) (struct super_block *sb, u64 ino, u32 gen));
> -- 
> 2.34.1
> 

-- 
Chuck Lever

