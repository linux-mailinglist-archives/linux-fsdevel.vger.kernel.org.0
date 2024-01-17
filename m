Return-Path: <linux-fsdevel+bounces-8172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F279283098C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5541F217E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14722314;
	Wed, 17 Jan 2024 15:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NX67Brwz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QA4/9OoF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3B21A19;
	Wed, 17 Jan 2024 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504622; cv=fail; b=PD4xgszkKwmGzEc/cyBxQo0L6FC0VFpRRJuAeySA+qj/Y86sD00VQYU0LgaRZhd+tflpDXVIRoGttBEn2yjTBRvV6bY3CgE0QFW3gjzu/zaTEN3DqBsCxdfWZD7Y8m3KQnv5kHIw+kDU7y/xSDh654ZEadbeM3pCl4VR5ihoqAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504622; c=relaxed/simple;
	bh=fUe8pQpqb22lUScyIflpiApEteOHUh6l0yt9FldAK9M=;
	h=Received:DKIM-Signature:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID; b=D56q0FWPEXzeowUlU+G4MdVmLYsOQX3g+rO47+zBECd4Qwuv5+TEtM8mf35xXqMXPVleD22ANT2VfIRF0kXmC45NHO/xAJB5gBwOBuML2HBPdqhCFHH4P3yHfTkUCcL2oA22Cf7lGnT/5ZvQE7Rc/DzOaabVX7CDcy8GR7Sr9tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NX67Brwz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QA4/9OoF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HF2GJA027563;
	Wed, 17 Jan 2024 15:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=O6iJ8IMcpR7JM5pwmyKcieLZeAKWH9vSmFcDwbG6JJI=;
 b=NX67BrwzQIH9VZx64mZl/nk1wMIk3RpEOxrxViu4EttJQnpSYsZFijWUBDJUvzzfIHom
 zq9nlqnImvNRIIhg8UKCkikrWrdfPuATQ+Hys2ZpD7PNJrBcpy0qEn0lulmnwWoxzQAH
 iiTgTD3fHC4q3SE0z+muv5CNLcpK/u0H7s/xnjHk/ICLK/9Hmd2LOvlsgLFhKf5P8RvV
 Wc7vHfrTgTiPM1ZwjQ84OkSLQfzbPVUn47x1MDAkJh54G69A0chFBmJMagBnGcrlvOXP
 xXn4ako10QxPPNYjB5J+he7xptYoA8RqsSfWpjMlFNIDOBn47zRe1NciJi6uV4op3lZb gA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkjjeg5bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 15:13:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HDx08O023280;
	Wed, 17 Jan 2024 15:13:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyaf049-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 15:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wbn06/fZgH9KzilxsmHs7SPljppZ5y3X4fQRoWlu6LlfP2K5vI17lkjfWrkYYGuykG2A4Ak/n7gJLz0szbr7w73w1hBHViqAT3/Xz9FmVE4e0FTet+Ivf0pxvuMlkJBkur98Etg43DDSk5yLCy2x5QXC3OwIcWFFrPubrhseImm2km4qIEjY7kzLs4V67nSAv6NnVxqPy/wo1YiSjhd24dEVNk8yqW50kXLIZTgoA81UvIindRBYHVMLsIiBacBBfCDpsTs8WGnGzS9+TqtmP1X3WYnzSqbTo7ztSpaZmk5KsTUIUv8R2GyBZu6QAPJLvuXXwaGlVyOlt3G9fyBDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6iJ8IMcpR7JM5pwmyKcieLZeAKWH9vSmFcDwbG6JJI=;
 b=Oueysv/3+2KKr2szfbwOsfYuNwniE/uBj020LMwECII2sWZmvZTLA2ZFYQ37lqVrHO7Xo2A2TWMUZ24+ClHDgwFkJKRXKujP+CbzAWUT5ploV8StAvOpTUl1WkANEGYvjGitWypbugpPxvqSBXYt4ZeIWtXvudP/NYmDgil0MKf5iDBi3XJl+8PKM86lpwWntq0nSCDdHsyR+YM0lL3dMupySm/EkmhmvizFNMKCaOJyJM4h6r6aYJDIdfUBhmaFXK1KByD2yIcKGpc7AMxv94tfeXse4j27ENjXSxgCkMuB0EBtEsMCJefEWHq1qHtv6BPRs4eNy10FoKqFuN4mYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6iJ8IMcpR7JM5pwmyKcieLZeAKWH9vSmFcDwbG6JJI=;
 b=QA4/9OoFxbhSgrbF1Kk8u6Qr8+qHSpFLJoLIGtGlDx3qoaYIVxGkZjiqWTwECrv7HXGlfmvdHnXbXL6X3l7Cla6Cu+ZDKnvDxjnj/9kvTds+yvSwyRulRq4r9B8WjfX5BjSzwaxbqroCOw6PKJiMm8d1nJ610WpjtcXPBkMWXq0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5121.namprd10.prod.outlook.com (2603:10b6:208:334::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 15:13:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 15:13:37 +0000
Date: Wed, 17 Jan 2024 10:13:32 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, Jan Kara <jack@suse.cz>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, v9fs@lists.linux.dev,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 04/20] filelock: fixups after the coccinelle changes
Message-ID: <ZafunB31nhPQtha+@tissot.1015granger.net>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
 <20240116-flsplit-v1-4-c9d0f4370a5d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-flsplit-v1-4-c9d0f4370a5d@kernel.org>
X-ClientProxiedBy: CH2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610::17)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d28b45-57d8-44b1-6752-08dc176ee152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nwqQflQBmP/Yo/cCxSW59m64Sj5UDvDkrLgO0y9L0cQMrIQmcJOQ59ZrH7Ow8hAXrxYnMloNQ2v0Q4m6QqiSlKY43ZJQ7SBB8SObLfd5OVyMoB5GbiNdLRo3RaqPp4y18cxWojp3iF80lXfakMSKDI4Y42LhC5bE21vd1BNNc+QwRY6KwEsTp6G7vLUl0OHIz4nNB2L8ctvUaPytg6zA5GMOp9g+z/H8DknJMJmHFYRD7PXWDrZaiQfSPQ/H/Rlu2/aX235wQqGrB1cOmcFtPz9+8Mx7x1J5Nt497PSQyftoyEmMiV60AInfBomQ0FhfR+GRPMaDDNed5doNc8P1m/d2JDx8UI25kPDIAOpXF63S8GouHU1UsipJUwkrNI5Kxb2PL8GuJtcd9tMmmzvLs4fn2kQbepviYxnuHJUHhpROMkSnpzP1M746nnP9vz5bV0o5ElQobKpS9tabC9Al5R10YRzjsE/rckbQn7Vql43Vw5EgIecx6XcO5NGAeF+5NhKZBDOVj4+Zd+6qG16N25JEcJ5GYtTaZL6P/LzuiMAfe5pRxrv53yGYR/6JUAsx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(38100700002)(83380400001)(86362001)(44832011)(316002)(6916009)(66556008)(66946007)(54906003)(30864003)(7416002)(2906002)(66476007)(7406005)(8936002)(5660300002)(4326008)(26005)(6486002)(478600001)(9686003)(6506007)(6512007)(6666004)(8676002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2GxoJ6DRuU17rcjdfBg+05hFNALFbsXiusZsZ8zLe/o32Q9zV7lFz02pltaY?=
 =?us-ascii?Q?zED2BOtrSWFH7Pm3TFBAtWF7iTcqrMDz4IHWy9S6AG1d5x/yA8Q4VQtPmMut?=
 =?us-ascii?Q?FKmW2WzI2SGF8o4dYSmbU2d5rCYUl1ZzGEQAC0rBNwybHNbAwDBwbCrX/Hk9?=
 =?us-ascii?Q?rGotiA9WirpqUqcxEiVv0V4AMP/fNEG3QLDHBV+6RlrF+d3TfldW2Mzw+sGU?=
 =?us-ascii?Q?Gdvz5xjhMaKuq20ZshFKvsK9FiUOMryhwN+Q0cyV4lfFCnKrFKUA5Li3SBGc?=
 =?us-ascii?Q?dp8ODwk9hxeFSnTyDr+rNLUJ4vkdr//m3ptDwT8igQKooKN/Dx5BFPqfEPl7?=
 =?us-ascii?Q?VNiwZAjOE28yDzZQXvrZ1X4QF7RnZcMgns0tCyWHInjlE0KweyNV/PAjKnAI?=
 =?us-ascii?Q?4KCSgdkkC6eKx5xu0teqgMcr7nG+YOY5yxxK0O46aQ3BYMHmLrsWInYV0Ykn?=
 =?us-ascii?Q?paAH9fF/hYPuo+lwVPZVgyf4PcnCOtxXqYUJ1KWsopDYSEEUJGXXYs+rpPW/?=
 =?us-ascii?Q?y8WZN2ofwNnXR/3GqHuWRl/QEzoxG6ODm8jy/nzZtaCR4Bd14Kzd85QQ2MzY?=
 =?us-ascii?Q?m1yomaD0mFQTdmWgosoXe08TyHvN7fIIaHzCvL9noB+v0zm4bkVxNlbqDjKE?=
 =?us-ascii?Q?GePIrLLOfUfCex3FA/BF/yhb6+elDwGHbwES4TU/knUHFDegK0K0jY48TRms?=
 =?us-ascii?Q?LlHyjJmfc/RSNWn8o4Aab2aHNh/s7zeljLfHOUT1vLsudwDR8kk/lO2+nxfw?=
 =?us-ascii?Q?bqsMZqBLnR86CL0YbJesLLAKR/H3ejSWD7jEK02YEiSaaP1DJoe0qEWFNfYu?=
 =?us-ascii?Q?C2BejL+ert+gJnVV3UqDEoPtn05aHV9B+z7RORlGHKpm4DCD/irvcTAJpWNT?=
 =?us-ascii?Q?wuALvese6T6ZXKcEsHrALDvFOWRJFFF/urLzg0ZYv/fGeCxfiaN2elOSz5ux?=
 =?us-ascii?Q?mSDMEzuqdi+GuZfWWpYuxaaFJ5yqoyWe00QxefSttXGyrrJO65AauEZO0vFd?=
 =?us-ascii?Q?m6SLyUwQDzBrRNtwxX/LhaB8WcS9UKxK989qXKixXri6O2llulKB0HOyIsxZ?=
 =?us-ascii?Q?s3jsrHu5l8ywtFQwwty+e+pt8V1E4bI8en3D1jXA5Q0Jh52njiHKdE8UfWtb?=
 =?us-ascii?Q?IKympeND8nUX6JV71ElZEbT93qFfqEDhuYoGcSw0ZvZMY1Snyf0aC1zcgmwI?=
 =?us-ascii?Q?PHf9tkYjbRxFsr1WLY/rSsHDLWc0VQcItwVmlVF3B5XWeFSCDVqZJWQ3ASw4?=
 =?us-ascii?Q?eZ5X5DfFZU8DqYK3m+J6nxiuezGlzPa6l3uDM3n4WtFzZk1ZSDyhyQJOWf1f?=
 =?us-ascii?Q?OkeAAVRYCf8YmyAqg2AB2g5yRENNkHi/RAQXdYvGr8TgyvFy7qxvAUqbJVBh?=
 =?us-ascii?Q?ZF8zIzy/7mjw6ZbecD13v25hKzuK/b0gA7LXXag3r70alLOk4Io4NWqDDeAh?=
 =?us-ascii?Q?77bX78iu59RdA0sCUwQbJmex8+vtyC21/r58cI+zZ7QatZPFiJesfahmb827?=
 =?us-ascii?Q?W7oLAjSWRRucmx/GXUDNWsTrwjnyuaMshg4UCzIdSozYyCxRV3gMip+f/Wqr?=
 =?us-ascii?Q?aQtlHI/1XIOO6Nsz3z3cNW1IAY50qknOAZIEVbL2TvzftnYThplxniNN/KsI?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jPUF/p4hxVIn3/iuVgN6/2sD4Er9PSyYqH9HnL54y8vKZdPvgYbNtlzhwYsRXCPLc99ccyUiml3M6gROCdRFXrtxOyFVxtOvl2k7iZFm16j3QfB4rDZN9UxSoC5DbYNMPCoDOcb/eI1Ec2gUlIAo1yqgPL4vQdH8ZGx87gYxwWKcfp7ZuoZdKvoZU+IqftJd3CM/xJcC1mm22X61NryMw2B5XEQBWcRa/CmhtX+WM3h1Df+jhotQYGxnEUmXkgiJw6zOPZCNaz1yu+eoRI/V8VZsDL5scodF5SFrldeoQldr/Q2cq5U9Mgr3h1XAs8MpC3AfXnQZhbPCEQzqMiuQ+i0y7T4Qubfvw9bgufG7CC5DYGOMQV12JB7kkGRHFn432b3tL+v7WEgqdZclpyquSJXRq04JklyUwo7Z5TtItLa3NEzTmmDbK4mrln3W0F6mSAsk9zmXFwrYVDWSNSAtD4IkVB+mI9MwBSOgNGvkuvvGOWPrYBT17xnVXLz/NuQvTiGZc4P5uaYhRqoZMwQoQS6ri1HoD9TOTNslgsS2/AEXwd1aXIXeG8IU+SQg1eKZMkUfO+D8Fo+RE7jtBrEVNCy4Qdjj0K1wGRZTcepPVrs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d28b45-57d8-44b1-6752-08dc176ee152
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:13:37.5658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyBrQTsw+J9lsqEdKzfaQRJiwY3Hy3UxK3yY54dmz9bsO3HdnENURqJBuZlO5oL9aZp8MSN0FDPrvR+58U8eRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170110
X-Proofpoint-ORIG-GUID: PDffZAb7dpQLSL1Mots-OGn4cHtkbyjX
X-Proofpoint-GUID: PDffZAb7dpQLSL1Mots-OGn4cHtkbyjX

On Tue, Jan 16, 2024 at 02:46:00PM -0500, Jeff Layton wrote:
> The coccinelle script doesn't catch quite everythng (particularly with
> embedded structs). These are some by-hand fixups after the split of
> common fields into struct file_lock_core.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

For the changes in fs/lockd/ and fs/nfsd/:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


> ---
>  fs/ceph/locks.c                 |  8 ++---
>  fs/lockd/clnt4xdr.c             |  8 ++---
>  fs/lockd/clntproc.c             |  6 ++--
>  fs/lockd/clntxdr.c              |  8 ++---
>  fs/lockd/svc4proc.c             | 10 +++---
>  fs/lockd/svclock.c              | 54 +++++++++++++++++----------------
>  fs/lockd/svcproc.c              | 10 +++---
>  fs/lockd/svcsubs.c              |  4 +--
>  fs/lockd/xdr.c                  |  8 ++---
>  fs/lockd/xdr4.c                 |  8 ++---
>  fs/locks.c                      | 67 +++++++++++++++++++++--------------------
>  fs/nfs/delegation.c             |  2 +-
>  fs/nfs/nfs4state.c              |  2 +-
>  fs/nfs/nfs4trace.h              |  4 +--
>  fs/nfs/write.c                  |  4 +--
>  fs/nfsd/nfs4callback.c          |  2 +-
>  fs/nfsd/nfs4state.c             |  4 +--
>  fs/smb/client/file.c            |  2 +-
>  fs/smb/server/vfs.c             |  2 +-
>  include/trace/events/afs.h      |  4 +--
>  include/trace/events/filelock.h | 32 ++++++++++----------
>  21 files changed, 126 insertions(+), 123 deletions(-)
> 
> diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> index ee12f9864980..55be5d231e38 100644
> --- a/fs/ceph/locks.c
> +++ b/fs/ceph/locks.c
> @@ -386,9 +386,9 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
>  	ctx = locks_inode_context(inode);
>  	if (ctx) {
>  		spin_lock(&ctx->flc_lock);
> -		list_for_each_entry(lock, &ctx->flc_posix, fl_list)
> +		list_for_each_entry(lock, &ctx->flc_posix, fl_core.fl_list)
>  			++(*fcntl_count);
> -		list_for_each_entry(lock, &ctx->flc_flock, fl_list)
> +		list_for_each_entry(lock, &ctx->flc_flock, fl_core.fl_list)
>  			++(*flock_count);
>  		spin_unlock(&ctx->flc_lock);
>  	}
> @@ -455,7 +455,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
>  		return 0;
>  
>  	spin_lock(&ctx->flc_lock);
> -	list_for_each_entry(lock, &ctx->flc_posix, fl_list) {
> +	list_for_each_entry(lock, &ctx->flc_posix, fl_core.fl_list) {
>  		++seen_fcntl;
>  		if (seen_fcntl > num_fcntl_locks) {
>  			err = -ENOSPC;
> @@ -466,7 +466,7 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
>  			goto fail;
>  		++l;
>  	}
> -	list_for_each_entry(lock, &ctx->flc_flock, fl_list) {
> +	list_for_each_entry(lock, &ctx->flc_flock, fl_core.fl_list) {
>  		++seen_flock;
>  		if (seen_flock > num_flock_locks) {
>  			err = -ENOSPC;
> diff --git a/fs/lockd/clnt4xdr.c b/fs/lockd/clnt4xdr.c
> index ed00bd2869a7..083a3b1bf288 100644
> --- a/fs/lockd/clnt4xdr.c
> +++ b/fs/lockd/clnt4xdr.c
> @@ -243,7 +243,7 @@ static void encode_nlm4_holder(struct xdr_stream *xdr,
>  	u64 l_offset, l_len;
>  	__be32 *p;
>  
> -	encode_bool(xdr, lock->fl.fl_type == F_RDLCK);
> +	encode_bool(xdr, lock->fl.fl_core.fl_type == F_RDLCK);
>  	encode_int32(xdr, lock->svid);
>  	encode_netobj(xdr, lock->oh.data, lock->oh.len);
>  
> @@ -357,7 +357,7 @@ static void nlm4_xdr_enc_testargs(struct rpc_rqst *req,
>  	const struct nlm_lock *lock = &args->lock;
>  
>  	encode_cookie(xdr, &args->cookie);
> -	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
> +	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
>  	encode_nlm4_lock(xdr, lock);
>  }
>  
> @@ -380,7 +380,7 @@ static void nlm4_xdr_enc_lockargs(struct rpc_rqst *req,
>  
>  	encode_cookie(xdr, &args->cookie);
>  	encode_bool(xdr, args->block);
> -	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
> +	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
>  	encode_nlm4_lock(xdr, lock);
>  	encode_bool(xdr, args->reclaim);
>  	encode_int32(xdr, args->state);
> @@ -403,7 +403,7 @@ static void nlm4_xdr_enc_cancargs(struct rpc_rqst *req,
>  
>  	encode_cookie(xdr, &args->cookie);
>  	encode_bool(xdr, args->block);
> -	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
> +	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
>  	encode_nlm4_lock(xdr, lock);
>  }
>  
> diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> index ac1d07034346..15461e8952b4 100644
> --- a/fs/lockd/clntproc.c
> +++ b/fs/lockd/clntproc.c
> @@ -143,7 +143,7 @@ static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
>  	lock->svid = fl->fl_u.nfs_fl.owner->pid;
>  	lock->fl.fl_start = fl->fl_start;
>  	lock->fl.fl_end = fl->fl_end;
> -	lock->fl.fl_type = fl->fl_core.fl_type;
> +	lock->fl.fl_core.fl_type = fl->fl_core.fl_type;
>  }
>  
>  static void nlmclnt_release_lockargs(struct nlm_rqst *req)
> @@ -448,8 +448,8 @@ nlmclnt_test(struct nlm_rqst *req, struct file_lock *fl)
>  			 */
>  			fl->fl_start = req->a_res.lock.fl.fl_start;
>  			fl->fl_end = req->a_res.lock.fl.fl_end;
> -			fl->fl_core.fl_type = req->a_res.lock.fl.fl_type;
> -			fl->fl_core.fl_pid = -req->a_res.lock.fl.fl_pid;
> +			fl->fl_core.fl_type = req->a_res.lock.fl.fl_core.fl_type;
> +			fl->fl_core.fl_pid = -req->a_res.lock.fl.fl_core.fl_pid;
>  			break;
>  		default:
>  			status = nlm_stat_to_errno(req->a_res.status);
> diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
> index b0b87a00cd81..6823e2d3bf75 100644
> --- a/fs/lockd/clntxdr.c
> +++ b/fs/lockd/clntxdr.c
> @@ -238,7 +238,7 @@ static void encode_nlm_holder(struct xdr_stream *xdr,
>  	u32 l_offset, l_len;
>  	__be32 *p;
>  
> -	encode_bool(xdr, lock->fl.fl_type == F_RDLCK);
> +	encode_bool(xdr, lock->fl.fl_core.fl_type == F_RDLCK);
>  	encode_int32(xdr, lock->svid);
>  	encode_netobj(xdr, lock->oh.data, lock->oh.len);
>  
> @@ -357,7 +357,7 @@ static void nlm_xdr_enc_testargs(struct rpc_rqst *req,
>  	const struct nlm_lock *lock = &args->lock;
>  
>  	encode_cookie(xdr, &args->cookie);
> -	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
> +	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
>  	encode_nlm_lock(xdr, lock);
>  }
>  
> @@ -380,7 +380,7 @@ static void nlm_xdr_enc_lockargs(struct rpc_rqst *req,
>  
>  	encode_cookie(xdr, &args->cookie);
>  	encode_bool(xdr, args->block);
> -	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
> +	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
>  	encode_nlm_lock(xdr, lock);
>  	encode_bool(xdr, args->reclaim);
>  	encode_int32(xdr, args->state);
> @@ -403,7 +403,7 @@ static void nlm_xdr_enc_cancargs(struct rpc_rqst *req,
>  
>  	encode_cookie(xdr, &args->cookie);
>  	encode_bool(xdr, args->block);
> -	encode_bool(xdr, lock->fl.fl_type == F_WRLCK);
> +	encode_bool(xdr, lock->fl.fl_core.fl_type == F_WRLCK);
>  	encode_nlm_lock(xdr, lock);
>  }
>  
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index b72023a6b4c1..fc98c3c74da8 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -52,16 +52,16 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
>  		*filp = file;
>  
>  		/* Set up the missing parts of the file_lock structure */
> -		lock->fl.fl_flags = FL_POSIX;
> -		lock->fl.fl_file  = file->f_file[mode];
> -		lock->fl.fl_pid = current->tgid;
> +		lock->fl.fl_core.fl_flags = FL_POSIX;
> +		lock->fl.fl_core.fl_file  = file->f_file[mode];
> +		lock->fl.fl_core.fl_pid = current->tgid;
>  		lock->fl.fl_start = (loff_t)lock->lock_start;
>  		lock->fl.fl_end = lock->lock_len ?
>  				   (loff_t)(lock->lock_start + lock->lock_len - 1) :
>  				   OFFSET_MAX;
>  		lock->fl.fl_lmops = &nlmsvc_lock_operations;
>  		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> -		if (!lock->fl.fl_owner) {
> +		if (!lock->fl.fl_core.fl_owner) {
>  			/* lockowner allocation has failed */
>  			nlmsvc_release_host(host);
>  			return nlm_lck_denied_nolocks;
> @@ -106,7 +106,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
>  	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
>  		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
>  
> -	test_owner = argp->lock.fl.fl_owner;
> +	test_owner = argp->lock.fl.fl_core.fl_owner;
>  	/* Now check for conflicting locks */
>  	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie);
>  	if (resp->status == nlm_drop_reply)
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index 520886a4b57e..59973f9d0406 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -150,9 +150,10 @@ nlmsvc_lookup_block(struct nlm_file *file, struct nlm_lock *lock)
>  	struct file_lock	*fl;
>  
>  	dprintk("lockd: nlmsvc_lookup_block f=%p pd=%d %Ld-%Ld ty=%d\n",
> -				file, lock->fl.fl_pid,
> +				file, lock->fl.fl_core.fl_pid,
>  				(long long)lock->fl.fl_start,
> -				(long long)lock->fl.fl_end, lock->fl.fl_type);
> +				(long long)lock->fl.fl_end,
> +				lock->fl.fl_core.fl_type);
>  	spin_lock(&nlm_blocked_lock);
>  	list_for_each_entry(block, &nlm_blocked, b_list) {
>  		fl = &block->b_call->a_args.lock.fl;
> @@ -244,7 +245,7 @@ nlmsvc_create_block(struct svc_rqst *rqstp, struct nlm_host *host,
>  		goto failed_free;
>  
>  	/* Set notifier function for VFS, and init args */
> -	call->a_args.lock.fl.fl_flags |= FL_SLEEP;
> +	call->a_args.lock.fl.fl_core.fl_flags |= FL_SLEEP;
>  	call->a_args.lock.fl.fl_lmops = &nlmsvc_lock_operations;
>  	nlmclnt_next_cookie(&call->a_args.cookie);
>  
> @@ -402,8 +403,8 @@ static struct nlm_lockowner *nlmsvc_find_lockowner(struct nlm_host *host, pid_t
>  void
>  nlmsvc_release_lockowner(struct nlm_lock *lock)
>  {
> -	if (lock->fl.fl_owner)
> -		nlmsvc_put_lockowner(lock->fl.fl_owner);
> +	if (lock->fl.fl_core.fl_owner)
> +		nlmsvc_put_lockowner(lock->fl.fl_core.fl_owner);
>  }
>  
>  void nlmsvc_locks_init_private(struct file_lock *fl, struct nlm_host *host,
> @@ -425,7 +426,7 @@ static int nlmsvc_setgrantargs(struct nlm_rqst *call, struct nlm_lock *lock)
>  
>  	/* set default data area */
>  	call->a_args.lock.oh.data = call->a_owner;
> -	call->a_args.lock.svid = ((struct nlm_lockowner *)lock->fl.fl_owner)->pid;
> +	call->a_args.lock.svid = ((struct nlm_lockowner *) lock->fl.fl_core.fl_owner)->pid;
>  
>  	if (lock->oh.len > NLMCLNT_OHSIZE) {
>  		void *data = kmalloc(lock->oh.len, GFP_KERNEL);
> @@ -489,7 +490,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
>  
>  	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
>  				inode->i_sb->s_id, inode->i_ino,
> -				lock->fl.fl_type, lock->fl.fl_pid,
> +				lock->fl.fl_core.fl_type,
> +				lock->fl.fl_core.fl_pid,
>  				(long long)lock->fl.fl_start,
>  				(long long)lock->fl.fl_end,
>  				wait);
> @@ -512,7 +514,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
>  			goto out;
>  		lock = &block->b_call->a_args.lock;
>  	} else
> -		lock->fl.fl_flags &= ~FL_SLEEP;
> +		lock->fl.fl_core.fl_flags &= ~FL_SLEEP;
>  
>  	if (block->b_flags & B_QUEUED) {
>  		dprintk("lockd: nlmsvc_lock deferred block %p flags %d\n",
> @@ -560,10 +562,10 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
>  	spin_unlock(&nlm_blocked_lock);
>  
>  	if (!wait)
> -		lock->fl.fl_flags &= ~FL_SLEEP;
> +		lock->fl.fl_core.fl_flags &= ~FL_SLEEP;
>  	mode = lock_to_openmode(&lock->fl);
>  	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
> -	lock->fl.fl_flags &= ~FL_SLEEP;
> +	lock->fl.fl_core.fl_flags &= ~FL_SLEEP;
>  
>  	dprintk("lockd: vfs_lock_file returned %d\n", error);
>  	switch (error) {
> @@ -616,7 +618,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
>  	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
>  				nlmsvc_file_inode(file)->i_sb->s_id,
>  				nlmsvc_file_inode(file)->i_ino,
> -				lock->fl.fl_type,
> +				lock->fl.fl_core.fl_type,
>  				(long long)lock->fl.fl_start,
>  				(long long)lock->fl.fl_end);
>  
> @@ -636,19 +638,19 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
>  		goto out;
>  	}
>  
> -	if (lock->fl.fl_type == F_UNLCK) {
> +	if (lock->fl.fl_core.fl_type == F_UNLCK) {
>  		ret = nlm_granted;
>  		goto out;
>  	}
>  
>  	dprintk("lockd: conflicting lock(ty=%d, %Ld-%Ld)\n",
> -		lock->fl.fl_type, (long long)lock->fl.fl_start,
> +		lock->fl.fl_core.fl_type, (long long)lock->fl.fl_start,
>  		(long long)lock->fl.fl_end);
>  	conflock->caller = "somehost";	/* FIXME */
>  	conflock->len = strlen(conflock->caller);
>  	conflock->oh.len = 0;		/* don't return OH info */
> -	conflock->svid = lock->fl.fl_pid;
> -	conflock->fl.fl_type = lock->fl.fl_type;
> +	conflock->svid = lock->fl.fl_core.fl_pid;
> +	conflock->fl.fl_core.fl_type = lock->fl.fl_core.fl_type;
>  	conflock->fl.fl_start = lock->fl.fl_start;
>  	conflock->fl.fl_end = lock->fl.fl_end;
>  	locks_release_private(&lock->fl);
> @@ -673,21 +675,21 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
>  	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=%d, %Ld-%Ld)\n",
>  				nlmsvc_file_inode(file)->i_sb->s_id,
>  				nlmsvc_file_inode(file)->i_ino,
> -				lock->fl.fl_pid,
> +				lock->fl.fl_core.fl_pid,
>  				(long long)lock->fl.fl_start,
>  				(long long)lock->fl.fl_end);
>  
>  	/* First, cancel any lock that might be there */
>  	nlmsvc_cancel_blocked(net, file, lock);
>  
> -	lock->fl.fl_type = F_UNLCK;
> -	lock->fl.fl_file = file->f_file[O_RDONLY];
> -	if (lock->fl.fl_file)
> -		error = vfs_lock_file(lock->fl.fl_file, F_SETLK,
> +	lock->fl.fl_core.fl_type = F_UNLCK;
> +	lock->fl.fl_core.fl_file = file->f_file[O_RDONLY];
> +	if (lock->fl.fl_core.fl_file)
> +		error = vfs_lock_file(lock->fl.fl_core.fl_file, F_SETLK,
>  					&lock->fl, NULL);
> -	lock->fl.fl_file = file->f_file[O_WRONLY];
> -	if (lock->fl.fl_file)
> -		error |= vfs_lock_file(lock->fl.fl_file, F_SETLK,
> +	lock->fl.fl_core.fl_file = file->f_file[O_WRONLY];
> +	if (lock->fl.fl_core.fl_file)
> +		error |= vfs_lock_file(lock->fl.fl_core.fl_file, F_SETLK,
>  					&lock->fl, NULL);
>  
>  	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
> @@ -710,7 +712,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
>  	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
>  				nlmsvc_file_inode(file)->i_sb->s_id,
>  				nlmsvc_file_inode(file)->i_ino,
> -				lock->fl.fl_pid,
> +				lock->fl.fl_core.fl_pid,
>  				(long long)lock->fl.fl_start,
>  				(long long)lock->fl.fl_end);
>  
> @@ -863,12 +865,12 @@ nlmsvc_grant_blocked(struct nlm_block *block)
>  	/* vfs_lock_file() can mangle fl_start and fl_end, but we need
>  	 * them unchanged for the GRANT_MSG
>  	 */
> -	lock->fl.fl_flags |= FL_SLEEP;
> +	lock->fl.fl_core.fl_flags |= FL_SLEEP;
>  	fl_start = lock->fl.fl_start;
>  	fl_end = lock->fl.fl_end;
>  	mode = lock_to_openmode(&lock->fl);
>  	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
> -	lock->fl.fl_flags &= ~FL_SLEEP;
> +	lock->fl.fl_core.fl_flags &= ~FL_SLEEP;
>  	lock->fl.fl_start = fl_start;
>  	lock->fl.fl_end = fl_end;
>  
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index 32784f508c81..1809a1055e1e 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -77,12 +77,12 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
>  
>  		/* Set up the missing parts of the file_lock structure */
>  		mode = lock_to_openmode(&lock->fl);
> -		lock->fl.fl_flags = FL_POSIX;
> -		lock->fl.fl_file  = file->f_file[mode];
> -		lock->fl.fl_pid = current->tgid;
> +		lock->fl.fl_core.fl_flags = FL_POSIX;
> +		lock->fl.fl_core.fl_file  = file->f_file[mode];
> +		lock->fl.fl_core.fl_pid = current->tgid;
>  		lock->fl.fl_lmops = &nlmsvc_lock_operations;
>  		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
> -		if (!lock->fl.fl_owner) {
> +		if (!lock->fl.fl_core.fl_owner) {
>  			/* lockowner allocation has failed */
>  			nlmsvc_release_host(host);
>  			return nlm_lck_denied_nolocks;
> @@ -127,7 +127,7 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
>  	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
>  		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
>  
> -	test_owner = argp->lock.fl.fl_owner;
> +	test_owner = argp->lock.fl.fl_core.fl_owner;
>  
>  	/* Now check for conflicting locks */
>  	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host, &argp->lock, &resp->lock, &resp->cookie));
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index 61b5c7ef8a12..f7e7ec6ac6df 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -218,7 +218,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
>  again:
>  	file->f_locks = 0;
>  	spin_lock(&flctx->flc_lock);
> -	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> +	list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
>  		if (fl->fl_lmops != &nlmsvc_lock_operations)
>  			continue;
>  
> @@ -272,7 +272,7 @@ nlm_file_inuse(struct nlm_file *file)
>  
>  	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
>  		spin_lock(&flctx->flc_lock);
> -		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> +		list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
>  			if (fl->fl_lmops == &nlmsvc_lock_operations) {
>  				spin_unlock(&flctx->flc_lock);
>  				return 1;
> diff --git a/fs/lockd/xdr.c b/fs/lockd/xdr.c
> index 4a676a51eb6c..91611a909ad4 100644
> --- a/fs/lockd/xdr.c
> +++ b/fs/lockd/xdr.c
> @@ -164,7 +164,7 @@ nlmsvc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  	if (!svcxdr_decode_lock(xdr, &argp->lock))
>  		return false;
>  	if (exclusive)
> -		argp->lock.fl.fl_type = F_WRLCK;
> +		argp->lock.fl.fl_core.fl_type = F_WRLCK;
>  
>  	return true;
>  }
> @@ -184,7 +184,7 @@ nlmsvc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  	if (!svcxdr_decode_lock(xdr, &argp->lock))
>  		return false;
>  	if (exclusive)
> -		argp->lock.fl.fl_type = F_WRLCK;
> +		argp->lock.fl.fl_core.fl_type = F_WRLCK;
>  	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
>  		return false;
>  	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
> @@ -209,7 +209,7 @@ nlmsvc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  	if (!svcxdr_decode_lock(xdr, &argp->lock))
>  		return false;
>  	if (exclusive)
> -		argp->lock.fl.fl_type = F_WRLCK;
> +		argp->lock.fl.fl_core.fl_type = F_WRLCK;
>  
>  	return true;
>  }
> @@ -223,7 +223,7 @@ nlmsvc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  		return false;
>  	if (!svcxdr_decode_lock(xdr, &argp->lock))
>  		return false;
> -	argp->lock.fl.fl_type = F_UNLCK;
> +	argp->lock.fl.fl_core.fl_type = F_UNLCK;
>  
>  	return true;
>  }
> diff --git a/fs/lockd/xdr4.c b/fs/lockd/xdr4.c
> index 67e53f91717a..ba0206d28457 100644
> --- a/fs/lockd/xdr4.c
> +++ b/fs/lockd/xdr4.c
> @@ -159,7 +159,7 @@ nlm4svc_decode_testargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  	if (!svcxdr_decode_lock(xdr, &argp->lock))
>  		return false;
>  	if (exclusive)
> -		argp->lock.fl.fl_type = F_WRLCK;
> +		argp->lock.fl.fl_core.fl_type = F_WRLCK;
>  
>  	return true;
>  }
> @@ -179,7 +179,7 @@ nlm4svc_decode_lockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  	if (!svcxdr_decode_lock(xdr, &argp->lock))
>  		return false;
>  	if (exclusive)
> -		argp->lock.fl.fl_type = F_WRLCK;
> +		argp->lock.fl.fl_core.fl_type = F_WRLCK;
>  	if (xdr_stream_decode_bool(xdr, &argp->reclaim) < 0)
>  		return false;
>  	if (xdr_stream_decode_u32(xdr, &argp->state) < 0)
> @@ -204,7 +204,7 @@ nlm4svc_decode_cancargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  	if (!svcxdr_decode_lock(xdr, &argp->lock))
>  		return false;
>  	if (exclusive)
> -		argp->lock.fl.fl_type = F_WRLCK;
> +		argp->lock.fl.fl_core.fl_type = F_WRLCK;
>  
>  	return true;
>  }
> @@ -218,7 +218,7 @@ nlm4svc_decode_unlockargs(struct svc_rqst *rqstp, struct xdr_stream *xdr)
>  		return false;
>  	if (!svcxdr_decode_lock(xdr, &argp->lock))
>  		return false;
> -	argp->lock.fl.fl_type = F_UNLCK;
> +	argp->lock.fl.fl_core.fl_type = F_UNLCK;
>  
>  	return true;
>  }
> diff --git a/fs/locks.c b/fs/locks.c
> index cd6ffa22a1ce..afe6e82a6207 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -70,11 +70,11 @@
>  
>  #include <linux/uaccess.h>
>  
> -#define IS_POSIX(fl)	(fl->fl_flags & FL_POSIX)
> -#define IS_FLOCK(fl)	(fl->fl_flags & FL_FLOCK)
> -#define IS_LEASE(fl)	(fl->fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
> -#define IS_OFDLCK(fl)	(fl->fl_flags & FL_OFDLCK)
> -#define IS_REMOTELCK(fl)	(fl->fl_pid <= 0)
> +#define IS_POSIX(fl)	(fl->fl_core.fl_flags & FL_POSIX)
> +#define IS_FLOCK(fl)	(fl->fl_core.fl_flags & FL_FLOCK)
> +#define IS_LEASE(fl)	(fl->fl_core.fl_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
> +#define IS_OFDLCK(fl)	(fl->fl_core.fl_flags & FL_OFDLCK)
> +#define IS_REMOTELCK(fl)	(fl->fl_core.fl_pid <= 0)
>  
>  static bool lease_breaking(struct file_lock *fl)
>  {
> @@ -206,7 +206,7 @@ locks_dump_ctx_list(struct list_head *list, char *list_type)
>  {
>  	struct file_lock *fl;
>  
> -	list_for_each_entry(fl, list, fl_list) {
> +	list_for_each_entry(fl, list, fl_core.fl_list) {
>  		pr_warn("%s: fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n", list_type,
>  			fl->fl_core.fl_owner, fl->fl_core.fl_flags,
>  			fl->fl_core.fl_type, fl->fl_core.fl_pid);
> @@ -237,7 +237,7 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
>  	struct file_lock *fl;
>  	struct inode *inode = file_inode(filp);
>  
> -	list_for_each_entry(fl, list, fl_list)
> +	list_for_each_entry(fl, list, fl_core.fl_list)
>  		if (fl->fl_core.fl_file == filp)
>  			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%lx "
>  				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
> @@ -318,7 +318,7 @@ bool locks_owner_has_blockers(struct file_lock_context *flctx,
>  	struct file_lock *fl;
>  
>  	spin_lock(&flctx->flc_lock);
> -	list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> +	list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
>  		if (fl->fl_core.fl_owner != owner)
>  			continue;
>  		if (!list_empty(&fl->fl_core.fl_blocked_requests)) {
> @@ -345,7 +345,7 @@ locks_dispose_list(struct list_head *dispose)
>  	struct file_lock *fl;
>  
>  	while (!list_empty(dispose)) {
> -		fl = list_first_entry(dispose, struct file_lock, fl_list);
> +		fl = list_first_entry(dispose, struct file_lock, fl_core.fl_list);
>  		list_del_init(&fl->fl_core.fl_list);
>  		locks_free_lock(fl);
>  	}
> @@ -412,7 +412,7 @@ static void locks_move_blocks(struct file_lock *new, struct file_lock *fl)
>  	list_splice_init(&fl->fl_core.fl_blocked_requests,
>  			 &new->fl_core.fl_blocked_requests);
>  	list_for_each_entry(f, &new->fl_core.fl_blocked_requests,
> -			    fl_blocked_member)
> +			    fl_core.fl_blocked_member)
>  		f->fl_core.fl_blocker = new;
>  	spin_unlock(&blocked_lock_lock);
>  }
> @@ -675,7 +675,7 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
>  		struct file_lock *waiter;
>  
>  		waiter = list_first_entry(&blocker->fl_core.fl_blocked_requests,
> -					  struct file_lock, fl_blocked_member);
> +					  struct file_lock, fl_core.fl_blocked_member);
>  		__locks_delete_block(waiter);
>  		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
>  			waiter->fl_lmops->lm_notify(waiter);
> @@ -767,7 +767,7 @@ static void __locks_insert_block(struct file_lock *blocker,
>  
>  new_blocker:
>  	list_for_each_entry(fl, &blocker->fl_core.fl_blocked_requests,
> -			    fl_blocked_member)
> +			    fl_core.fl_blocked_member)
>  		if (conflict(fl, waiter)) {
>  			blocker =  fl;
>  			goto new_blocker;
> @@ -922,7 +922,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>  
>  retry:
>  	spin_lock(&ctx->flc_lock);
> -	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
> +	list_for_each_entry(cfl, &ctx->flc_posix, fl_core.fl_list) {
>  		if (!posix_test_locks_conflict(fl, cfl))
>  			continue;
>  		if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable
> @@ -985,7 +985,7 @@ static struct file_lock *what_owner_is_waiting_for(struct file_lock *block_fl)
>  {
>  	struct file_lock *fl;
>  
> -	hash_for_each_possible(blocked_hash, fl, fl_link, posix_owner_key(block_fl)) {
> +	hash_for_each_possible(blocked_hash, fl, fl_core.fl_link, posix_owner_key(block_fl)) {
>  		if (posix_same_owner(fl, block_fl)) {
>  			while (fl->fl_core.fl_blocker)
>  				fl = fl->fl_core.fl_blocker;
> @@ -1053,7 +1053,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
>  	if (request->fl_core.fl_flags & FL_ACCESS)
>  		goto find_conflict;
>  
> -	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
> +	list_for_each_entry(fl, &ctx->flc_flock, fl_core.fl_list) {
>  		if (request->fl_core.fl_file != fl->fl_core.fl_file)
>  			continue;
>  		if (request->fl_core.fl_type == fl->fl_core.fl_type)
> @@ -1070,7 +1070,7 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
>  	}
>  
>  find_conflict:
> -	list_for_each_entry(fl, &ctx->flc_flock, fl_list) {
> +	list_for_each_entry(fl, &ctx->flc_flock, fl_core.fl_list) {
>  		if (!flock_locks_conflict(request, fl))
>  			continue;
>  		error = -EAGAIN;
> @@ -1139,7 +1139,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  	 * blocker's list of waiters and the global blocked_hash.
>  	 */
>  	if (request->fl_core.fl_type != F_UNLCK) {
> -		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +		list_for_each_entry(fl, &ctx->flc_posix, fl_core.fl_list) {
>  			if (!posix_locks_conflict(request, fl))
>  				continue;
>  			if (fl->fl_lmops && fl->fl_lmops->lm_lock_expirable
> @@ -1185,13 +1185,13 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>  		goto out;
>  
>  	/* Find the first old lock with the same owner as the new lock */
> -	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +	list_for_each_entry(fl, &ctx->flc_posix, fl_core.fl_list) {
>  		if (posix_same_owner(request, fl))
>  			break;
>  	}
>  
>  	/* Process locks with this owner. */
> -	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_list) {
> +	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_core.fl_list) {
>  		if (!posix_same_owner(request, fl))
>  			break;
>  
> @@ -1433,7 +1433,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
>  
>  	lockdep_assert_held(&ctx->flc_lock);
>  
> -	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
> +	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_core.fl_list) {
>  		trace_time_out_leases(inode, fl);
>  		if (past_time(fl->fl_downgrade_time))
>  			lease_modify(fl, F_RDLCK, dispose);
> @@ -1472,7 +1472,7 @@ any_leases_conflict(struct inode *inode, struct file_lock *breaker)
>  
>  	lockdep_assert_held(&ctx->flc_lock);
>  
> -	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
>  		if (leases_conflict(fl, breaker))
>  			return true;
>  	}
> @@ -1528,7 +1528,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  			break_time++;	/* so that 0 means no break time */
>  	}
>  
> -	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
> +	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_core.fl_list) {
>  		if (!leases_conflict(fl, new_fl))
>  			continue;
>  		if (want_write) {
> @@ -1556,7 +1556,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
>  	}
>  
>  restart:
> -	fl = list_first_entry(&ctx->flc_lease, struct file_lock, fl_list);
> +	fl = list_first_entry(&ctx->flc_lease, struct file_lock, fl_core.fl_list);
>  	break_time = fl->fl_break_time;
>  	if (break_time != 0)
>  		break_time -= jiffies;
> @@ -1616,7 +1616,7 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
>  	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
>  		spin_lock(&ctx->flc_lock);
>  		fl = list_first_entry_or_null(&ctx->flc_lease,
> -					      struct file_lock, fl_list);
> +					      struct file_lock, fl_core.fl_list);
>  		if (fl && (fl->fl_core.fl_type == F_WRLCK))
>  			has_lease = true;
>  		spin_unlock(&ctx->flc_lock);
> @@ -1663,7 +1663,7 @@ int fcntl_getlease(struct file *filp)
>  		percpu_down_read(&file_rwsem);
>  		spin_lock(&ctx->flc_lock);
>  		time_out_leases(inode, &dispose);
> -		list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +		list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
>  			if (fl->fl_core.fl_file != filp)
>  				continue;
>  			type = target_leasetype(fl);
> @@ -1768,7 +1768,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lock **flp, void **pri
>  	 * except for this filp.
>  	 */
>  	error = -EAGAIN;
> -	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
>  		if (fl->fl_core.fl_file == filp &&
>  		    fl->fl_core.fl_owner == lease->fl_core.fl_owner) {
>  			my_fl = fl;
> @@ -1848,7 +1848,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
>  
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
> -	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
>  		if (fl->fl_core.fl_file == filp &&
>  		    fl->fl_core.fl_owner == owner) {
>  			victim = fl;
> @@ -2616,7 +2616,7 @@ locks_remove_lease(struct file *filp, struct file_lock_context *ctx)
>  
>  	percpu_down_read(&file_rwsem);
>  	spin_lock(&ctx->flc_lock);
> -	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list)
> +	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_core.fl_list)
>  		if (filp == fl->fl_core.fl_file)
>  			lease_modify(fl, F_UNLCK, &dispose);
>  	spin_unlock(&ctx->flc_lock);
> @@ -2781,8 +2781,9 @@ static struct file_lock *get_next_blocked_member(struct file_lock *node)
>  		return NULL;
>  
>  	/* Next member in the linked list could be itself */
> -	tmp = list_next_entry(node, fl_blocked_member);
> -	if (list_entry_is_head(tmp, &node->fl_core.fl_blocker->fl_blocked_requests, fl_blocked_member)
> +	tmp = list_next_entry(node, fl_core.fl_blocked_member);
> +	if (list_entry_is_head(tmp, &node->fl_core.fl_blocker->fl_core.fl_blocked_requests,
> +			       fl_core.fl_blocked_member)
>  		|| tmp == node) {
>  		return NULL;
>  	}
> @@ -2797,7 +2798,7 @@ static int locks_show(struct seq_file *f, void *v)
>  	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
>  	int level = 0;
>  
> -	cur = hlist_entry(v, struct file_lock, fl_link);
> +	cur = hlist_entry(v, struct file_lock, fl_core.fl_link);
>  
>  	if (locks_translate_pid(cur, proc_pidns) == 0)
>  		return 0;
> @@ -2817,7 +2818,7 @@ static int locks_show(struct seq_file *f, void *v)
>  			/* Turn left */
>  			cur = list_first_entry_or_null(&cur->fl_core.fl_blocked_requests,
>  						       struct file_lock,
> -						       fl_blocked_member);
> +						       fl_core.fl_blocked_member);
>  			level++;
>  		} else {
>  			/* Turn right */
> @@ -2841,7 +2842,7 @@ static void __show_fd_locks(struct seq_file *f,
>  {
>  	struct file_lock *fl;
>  
> -	list_for_each_entry(fl, head, fl_list) {
> +	list_for_each_entry(fl, head, fl_core.fl_list) {
>  
>  		if (filp != fl->fl_core.fl_file)
>  			continue;
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 31741967ab95..8c7c31d846a0 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -156,7 +156,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
>  	list = &flctx->flc_posix;
>  	spin_lock(&flctx->flc_lock);
>  restart:
> -	list_for_each_entry(fl, list, fl_list) {
> +	list_for_each_entry(fl, list, fl_core.fl_list) {
>  		if (nfs_file_open_context(fl->fl_core.fl_file)->state != state)
>  			continue;
>  		spin_unlock(&flctx->flc_lock);
> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> index a148b6ac4713..2d51523be647 100644
> --- a/fs/nfs/nfs4state.c
> +++ b/fs/nfs/nfs4state.c
> @@ -1529,7 +1529,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
>  	down_write(&nfsi->rwsem);
>  	spin_lock(&flctx->flc_lock);
>  restart:
> -	list_for_each_entry(fl, list, fl_list) {
> +	list_for_each_entry(fl, list, fl_core.fl_list) {
>  		if (nfs_file_open_context(fl->fl_core.fl_file)->state != state)
>  			continue;
>  		spin_unlock(&flctx->flc_lock);
> diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> index d27919d7241d..41fbbc626cc3 100644
> --- a/fs/nfs/nfs4trace.h
> +++ b/fs/nfs/nfs4trace.h
> @@ -699,7 +699,7 @@ DECLARE_EVENT_CLASS(nfs4_lock_event,
>  
>  			__entry->error = error < 0 ? -error : 0;
>  			__entry->cmd = cmd;
> -			__entry->type = request->fl_type;
> +			__entry->type = request->fl_core.fl_type;
>  			__entry->start = request->fl_start;
>  			__entry->end = request->fl_end;
>  			__entry->dev = inode->i_sb->s_dev;
> @@ -771,7 +771,7 @@ TRACE_EVENT(nfs4_set_lock,
>  
>  			__entry->error = error < 0 ? -error : 0;
>  			__entry->cmd = cmd;
> -			__entry->type = request->fl_type;
> +			__entry->type = request->fl_core.fl_type;
>  			__entry->start = request->fl_start;
>  			__entry->end = request->fl_end;
>  			__entry->dev = inode->i_sb->s_dev;
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index a096c84c4678..b2a6c8c3078d 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1335,12 +1335,12 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
>  	spin_lock(&flctx->flc_lock);
>  	if (!list_empty(&flctx->flc_posix)) {
>  		fl = list_first_entry(&flctx->flc_posix, struct file_lock,
> -					fl_list);
> +					fl_core.fl_list);
>  		if (is_whole_file_wrlock(fl))
>  			ret = 1;
>  	} else if (!list_empty(&flctx->flc_flock)) {
>  		fl = list_first_entry(&flctx->flc_flock, struct file_lock,
> -					fl_list);
> +					fl_core.fl_list);
>  		if (fl->fl_core.fl_type == F_WRLCK)
>  			ret = 1;
>  	}
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 926c29879c6a..e32ad2492eb1 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -674,7 +674,7 @@ static void nfs4_xdr_enc_cb_notify_lock(struct rpc_rqst *req,
>  	const struct nfsd4_callback *cb = data;
>  	const struct nfsd4_blocked_lock *nbl =
>  		container_of(cb, struct nfsd4_blocked_lock, nbl_cb);
> -	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)nbl->nbl_lock.fl_owner;
> +	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)nbl->nbl_lock.fl_core.fl_owner;
>  	struct nfs4_cb_compound_hdr hdr = {
>  		.ident = 0,
>  		.minorversion = cb->cb_clp->cl_minorversion,
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a6089dbcee9d..cf5d0b3a553f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7927,7 +7927,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
>  
>  	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
>  		spin_lock(&flctx->flc_lock);
> -		list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
> +		list_for_each_entry(fl, &flctx->flc_posix, fl_core.fl_list) {
>  			if (fl->fl_core.fl_owner == (fl_owner_t)lowner) {
>  				status = true;
>  				break;
> @@ -8456,7 +8456,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>  	if (!ctx)
>  		return 0;
>  	spin_lock(&ctx->flc_lock);
> -	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
> +	list_for_each_entry(fl, &ctx->flc_lease, fl_core.fl_list) {
>  		if (fl->fl_core.fl_flags == FL_LAYOUT)
>  			continue;
>  		if (fl->fl_lmops != &nfsd_lease_mng_ops) {
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 1305183842fd..024afd3a81d4 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -1581,7 +1581,7 @@ cifs_push_posix_locks(struct cifsFileInfo *cfile)
>  
>  	el = locks_to_send.next;
>  	spin_lock(&flctx->flc_lock);
> -	list_for_each_entry(flock, &flctx->flc_posix, fl_list) {
> +	list_for_each_entry(flock, &flctx->flc_posix, fl_core.fl_list) {
>  		if (el == &locks_to_send) {
>  			/*
>  			 * The list ended. We don't have enough allocated
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index f7bb6f19492b..c2abb9b6100d 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -337,7 +337,7 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
>  		return 0;
>  
>  	spin_lock(&ctx->flc_lock);
> -	list_for_each_entry(flock, &ctx->flc_posix, fl_list) {
> +	list_for_each_entry(flock, &ctx->flc_posix, fl_core.fl_list) {
>  		/* check conflict locks */
>  		if (flock->fl_end >= start && end >= flock->fl_start) {
>  			if (flock->fl_core.fl_type == F_RDLCK) {
> diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
> index 5194b7e6dc8d..bd6cf09856b3 100644
> --- a/include/trace/events/afs.h
> +++ b/include/trace/events/afs.h
> @@ -1195,8 +1195,8 @@ TRACE_EVENT(afs_flock_op,
>  		    __entry->from = fl->fl_start;
>  		    __entry->len = fl->fl_end - fl->fl_start + 1;
>  		    __entry->op = op;
> -		    __entry->type = fl->fl_type;
> -		    __entry->flags = fl->fl_flags;
> +		    __entry->type = fl->fl_core.fl_type;
> +		    __entry->flags = fl->fl_core.fl_flags;
>  		    __entry->debug_id = fl->fl_u.afs.debug_id;
>  			   ),
>  
> diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
> index 1646dadd7f37..92ed07544f94 100644
> --- a/include/trace/events/filelock.h
> +++ b/include/trace/events/filelock.h
> @@ -82,11 +82,11 @@ DECLARE_EVENT_CLASS(filelock_lock,
>  		__entry->fl = fl ? fl : NULL;
>  		__entry->s_dev = inode->i_sb->s_dev;
>  		__entry->i_ino = inode->i_ino;
> -		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
> -		__entry->fl_owner = fl ? fl->fl_owner : NULL;
> -		__entry->fl_pid = fl ? fl->fl_pid : 0;
> -		__entry->fl_flags = fl ? fl->fl_flags : 0;
> -		__entry->fl_type = fl ? fl->fl_type : 0;
> +		__entry->fl_blocker = fl ? fl->fl_core.fl_blocker : NULL;
> +		__entry->fl_owner = fl ? fl->fl_core.fl_owner : NULL;
> +		__entry->fl_pid = fl ? fl->fl_core.fl_pid : 0;
> +		__entry->fl_flags = fl ? fl->fl_core.fl_flags : 0;
> +		__entry->fl_type = fl ? fl->fl_core.fl_type : 0;
>  		__entry->fl_start = fl ? fl->fl_start : 0;
>  		__entry->fl_end = fl ? fl->fl_end : 0;
>  		__entry->ret = ret;
> @@ -137,10 +137,10 @@ DECLARE_EVENT_CLASS(filelock_lease,
>  		__entry->fl = fl ? fl : NULL;
>  		__entry->s_dev = inode->i_sb->s_dev;
>  		__entry->i_ino = inode->i_ino;
> -		__entry->fl_blocker = fl ? fl->fl_blocker : NULL;
> -		__entry->fl_owner = fl ? fl->fl_owner : NULL;
> -		__entry->fl_flags = fl ? fl->fl_flags : 0;
> -		__entry->fl_type = fl ? fl->fl_type : 0;
> +		__entry->fl_blocker = fl ? fl->fl_core.fl_blocker : NULL;
> +		__entry->fl_owner = fl ? fl->fl_core.fl_owner : NULL;
> +		__entry->fl_flags = fl ? fl->fl_core.fl_flags : 0;
> +		__entry->fl_type = fl ? fl->fl_core.fl_type : 0;
>  		__entry->fl_break_time = fl ? fl->fl_break_time : 0;
>  		__entry->fl_downgrade_time = fl ? fl->fl_downgrade_time : 0;
>  	),
> @@ -190,9 +190,9 @@ TRACE_EVENT(generic_add_lease,
>  		__entry->wcount = atomic_read(&inode->i_writecount);
>  		__entry->rcount = atomic_read(&inode->i_readcount);
>  		__entry->icount = atomic_read(&inode->i_count);
> -		__entry->fl_owner = fl->fl_owner;
> -		__entry->fl_flags = fl->fl_flags;
> -		__entry->fl_type = fl->fl_type;
> +		__entry->fl_owner = fl->fl_core.fl_owner;
> +		__entry->fl_flags = fl->fl_core.fl_flags;
> +		__entry->fl_type = fl->fl_core.fl_type;
>  	),
>  
>  	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
> @@ -220,11 +220,11 @@ TRACE_EVENT(leases_conflict,
>  
>  	TP_fast_assign(
>  		__entry->lease = lease;
> -		__entry->l_fl_flags = lease->fl_flags;
> -		__entry->l_fl_type = lease->fl_type;
> +		__entry->l_fl_flags = lease->fl_core.fl_flags;
> +		__entry->l_fl_type = lease->fl_core.fl_type;
>  		__entry->breaker = breaker;
> -		__entry->b_fl_flags = breaker->fl_flags;
> -		__entry->b_fl_type = breaker->fl_type;
> +		__entry->b_fl_flags = breaker->fl_core.fl_flags;
> +		__entry->b_fl_type = breaker->fl_core.fl_type;
>  		__entry->conflict = conflict;
>  	),
>  
> 
> -- 
> 2.43.0
> 

-- 
Chuck Lever

