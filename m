Return-Path: <linux-fsdevel+bounces-8171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F9830983
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B6D1F24C38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3122319;
	Wed, 17 Jan 2024 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLvkXUA6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B+PQPvlV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18639219F7;
	Wed, 17 Jan 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504556; cv=fail; b=NJZTnWva3BnPTWE+YBIJ2yCEexfHMrHlffe42z1J0SSnhVpF6ggQaP+9K7qLHcYlHVp8nhkJebRiPzfNX7TNelAf/r+raikDoHfcn3i6Qvm3rBcai678fTg9uekyXmrfiQVgGsHCMNr9nBIEKQ7/zKS1ClYvmeuudTOcFw0R5Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504556; c=relaxed/simple;
	bh=tn0qP9LtIoHFH/4WCeW/jJw7CWHWoZQUnwJSyoqlL9s=;
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
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID; b=lyhEPeVykqae1y1mP1liCLP9OHxcENRc4vIoLWoJE8vEEK+LgRdrrnrZSKuJkzzUATmM57qMohSLWJ6TLBjN2NyhrFP60lFKbRQaf+FSB1+39T2CN9giwcabWaW3oRg9ex/z372Bvo26JdRj07Mgpu7j9p0zXpDCbNNUhThHBB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lLvkXUA6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B+PQPvlV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40HF2LrE015085;
	Wed, 17 Jan 2024 15:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=7vsDE9Qt7OUvYs4/m0tFJXtZBWGxDA24dCW+IHMi6lk=;
 b=lLvkXUA6jo4ZrVW1bG1iJcfBbwEtq/oILcdGylg+Oz6vVXtxi+yGDCavRdBFnx1UMjnm
 iWZiqrLvrO22iYlvDXl7IXjSENFoJVXiSyExHeYl8Jjb5F6Tv0wnC/yJtcgKPqs5eb+W
 98gWbQOjzFwPUaSwVg30xuGZo9sgqVbNWaiFCkb8Xfx91HBVUqEamrLy5d/0E8NHMo6B
 JW5F6TgSeffQpWkDD3pisphexy2kbcE9TZFNzX/JElz4eptKFxBxLXj8x8Vny7eR9h0M
 nKzuviNiJbxLRCQPqk+LrF5ZJdEPRuGkyGB6kuGdFxtisXa0yPGy70fyt3WJAOTeqBYd cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkm2hqyf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 15:12:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40HFA7Y6020137;
	Wed, 17 Jan 2024 15:12:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgyaf2n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jan 2024 15:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC+45ZT8pRjzvR+1cav7WObqfGDaqLpgPg9/FDmy74pgHZt/K/K6c02V1vrpMRnMNrq3uxwIcF51oBKuGlMQBVYUWQH8zhxF/Qn2x1kZoD6sIva8UqNL9AvwNZaIa+Ih3WzEL7PIqJb4wEjkoY5xtbgA4UywGQAq9oi2bU8sEWtdUnqeDgl44AS5hQn3d13szuO3Axl0Z+Ne4y5QUIFuySSLcjPaOu4ondpitWjNiSB3kZPzZab9sIino9w0JMWG3O2Mkh7LxOE0FQf9qLna7bvpjVguUvMeANCfPnx3dqDxtvsmuPcuZ7MeygXCPoRkANhtG5rJ02k6QwJtESyVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vsDE9Qt7OUvYs4/m0tFJXtZBWGxDA24dCW+IHMi6lk=;
 b=PfNcj+0k/1wn2bC9dHWk5mRPZMNXO/Gc/pT6LWBOL6TSuNW6ELKVLbeCRqbmhgQla3f9qzy/wrelGkyJC0O8uTvx6Abps2MMIhCgC1p0PosgzPJSn/oq85R5L9q1jEfU8DikC8WIHRCeZEuwcdnobt37TBBzTI/Cx0Lm6xnq6dJW8i3F1d+Jn5M2PbBZyDHIEILL/XYxGCIADGhq6ZZqycIanWEMBffTMQTsaWSd63PIwt+mVPgCPkaCWuZNMY0MqXDVjwIFLDIN+pYIlNb0D2YffCJvPc69rY7/ssUq3We0AI/NvLj2VCO39JHnPA4PT5HqiWJzcf0OJ2bx9tCP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vsDE9Qt7OUvYs4/m0tFJXtZBWGxDA24dCW+IHMi6lk=;
 b=B+PQPvlVMTlj6V+4QWlipXN+bGNu2q6Kon/e+TDlmIpOtqYgn/o0zgl+Yp0q2hr4FUXlm+Cg4MOqOkkGEMS35LKKmI+35r2Cq0SCF96T9el1Evt+zJTkt/E9Z1MgjoKl3Z8D7wZvs+bV4PwdVO27wODZWci79wFOsqrmDiHR5do=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5899.namprd10.prod.outlook.com (2603:10b6:208:3d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 15:12:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4fce:4653:ef69:1b01%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 15:12:35 +0000
Date: Wed, 17 Jan 2024 10:12:30 -0500
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
Subject: Re: [PATCH 00/20] filelock: split struct file_lock into file_lock
 and file_lease structs
Message-ID: <ZafuXpR4Y8Y6HFFl@tissot.1015granger.net>
References: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-flsplit-v1-0-c9d0f4370a5d@kernel.org>
X-ClientProxiedBy: CH0PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:610:33::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 50511efe-a713-4dae-11e3-08dc176ebc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3Zzue5qsRvBJ1c4OHKGv3tQ14MMM/bXsylVF4Gd8/hZmVP/taw+Wm9omfzrrmVY9I6SRpHkF9QoLdHx2VOB/mJ9coT3YFbj08mHCW0N4bteuZTpXjPO+JBHfOGILr3meUzgeKU2SbsvmxiOJ1tebxHtPIKUtwZ+H6dMxtAG3r+zRSzsRaUMww0R2/w0Y3IBIn8Q2DTYkhrBxulLWf+7oElpNkmWN+Rqc1RxdQDbl9W/wLBSwBsty/Bhbti1VV32grECdFGfcycrNAmbKVjaz+C4DVaRpLHoasAk70y37q6GxEhJRjcKIOYJSitSIUPQsTFE1seTMn8SCaOt0qpbPf5CZDsc2seTVr/Zud3wFBO6UUedr5pFHceJgbodMXF508O2LTFnTNtz6Vwx/0Hu/eXe9d3En09MTel1VkZtSFYz2fxdL+5NdHWQHdNTluMk9L2jqUg8yKwEEBytPjozC2t1mYpYDAeHa4qscpN/1RhXlgZhzEM9esJSPgLbvthxY7F0YEPk0dq4S+jdbGjLFRUWvhSSQgRLQcjRwo/sapgWANsinSp9nhit/mqw+ED/w
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(9686003)(6512007)(26005)(6506007)(38100700002)(83380400001)(6666004)(66556008)(66946007)(478600001)(86362001)(6486002)(6916009)(66899024)(54906003)(316002)(8676002)(8936002)(4326008)(66476007)(44832011)(41300700001)(7406005)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?L3f/jSU5YcAtUCmD7cE9EfYHQslwHkwiMCHYot9QE9IpFYTzcvNnRO85yIJc?=
 =?us-ascii?Q?pG0Z5YwmF48WxyU2GnFvDRu6gHfLXgcIrjHithF+bVWR8nBQ9ggOJAgN3Stz?=
 =?us-ascii?Q?CauLcuqnUgh5JERaOppfM7DBqJDY8NjGyfoJQShMM06vhBBOgHMB/qJDdSNT?=
 =?us-ascii?Q?s5AoKkwmYVACkzLAfccImf9AztWqHAK08afUjk6eWtds6515Bu1sPIVPxeEg?=
 =?us-ascii?Q?BxcJOFxlBxkwp9G8SnLXReiGu9M3GvWvgETNXKGLYiI7ax/dzyW6oti835+9?=
 =?us-ascii?Q?b0SiAjF+ejfVhfKdFIoIsi5Xx87JoQcbBn+uJJaXHDszhaSrgo6dI/nuRCB/?=
 =?us-ascii?Q?KEMIWTtvak6TkCq9dGflD+mw/ZUEwkaTASkegqc4mnFog5BYp7UZombSXN6M?=
 =?us-ascii?Q?1EXteUdfaLOoaCpjCqlFGX0X33V3+B3emZSXR6Ivkkjkb8pzlrieRR9KeGRY?=
 =?us-ascii?Q?bVunV5eujgvNaxnzxjLNKqGRYInarrdYWY0/pwYUoPQm9ihOyFd1d8l/Ften?=
 =?us-ascii?Q?Ww2O6rVCRQBMJHQNF6wObXvcUN8OQBbUMT8z7JdyHm3cGh7HgKvamXnEoaph?=
 =?us-ascii?Q?3IttTzmHqTQ79N8KoyZRvRx+FScLxoFzDxVmn2JLw/C93rZYTlzYk+3PbDGq?=
 =?us-ascii?Q?LrY//ihxMldZO9g/BuMA+sxkgHWlZSdADaqptIbCsp1SjiW3D1lU7fz7iAs6?=
 =?us-ascii?Q?3COVwwTxHMRNngrZ8a10e/4wlCbjriWpbMZrV56t1X6ioCm/UR6RaVVAwrD+?=
 =?us-ascii?Q?M7S1ITnHQAoMSddM2UgWL+UZZMFQGw1EpJevcgLLNTDJ8DMrsImRkVPtI3br?=
 =?us-ascii?Q?/4B1rEqIgUwJ3Ela2Q5xpx2T0zQXPvDG2hpVCremR1+1E8vndFFTIrL84/Zh?=
 =?us-ascii?Q?CjVLX6/eK+P0Zsvtdd4k2m7/KJOPctFoBKEf0IqFcUyyo5QzG2Gl2KcakJ8O?=
 =?us-ascii?Q?WvEMNDgJKKxftaRo2xLYSgaJWVEsJXvoXrehP5kddQial/gyop75FzX1QmEt?=
 =?us-ascii?Q?sOo+czOu3PoOaQ9AOxBXNfrgv/cFEPOVtqi55rD5D5cXu7vAliGOSaJ4xfts?=
 =?us-ascii?Q?B+IyYM7MzWa2Y3H/xvY9sF1cPCnGoOJx5IjqLD/yDliUtvI7A1k6eia7jwup?=
 =?us-ascii?Q?Dj4qsZKGu0Vbq3Ur9JiNp6bnm+AI134PqDwBJjCMEtOVIhGVdxYzG8bN4jWi?=
 =?us-ascii?Q?VmmwCyaGD11Wg0iqlpgsq2nSUNtbKfd8Uj4rPm3Vv+bwwX/U9BYgG8Yq6HtY?=
 =?us-ascii?Q?/nAqYQ+L2Q3kbiCiW3CDhax5M1Le2HKaYOhmUYb4pwimbtic7evP+NbpS1Iy?=
 =?us-ascii?Q?LE+5CcPPF3PrZgpJhXquB1M5THqGZvauEFvmkhHBVC4HeSxSkkIpQ87W7PcO?=
 =?us-ascii?Q?vSqf6Ko0Spqcj7TC/S7kAS81B1VMKYL/awf0xAb+tvwJrTXIDRrHcftaxaca?=
 =?us-ascii?Q?fiX1kNxqeAObkpCnd6CKir5c2sR/ACyUZPwiNrJytapZkYCq3ZtBVxylPGER?=
 =?us-ascii?Q?0M2Lzf9RpI4iLiql5zAgoOYlJ6qbQrStg4VOgzR8fhuDilnkR2DsFoI8XXKC?=
 =?us-ascii?Q?RLRsJUuUtuFMuHESrFwEAiN3XtbR00VDGUrgms+L2B4N6TqSfdo001r24JKv?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1WYn3GS/LDrgUiFWJ8+qHlxNSRbJg0Iw6xwoICCCTfg7n7oeBPzHNnEG+aP7lC36te213Zz6rp/HMsVqFLr1BQJU6EZjhd0ciyu5JG/WRjeQ61emlmSoD59i0yqCGQShfqTJXoWHp+353eiyx+bufJdnP7d1Bmb9VA1BsQfpdgnfNCdGHoiC5B1wDoJ1EluDGiRwciiQRAT2QPOfHvGzE4Edx6NBTdr9jTrTGqrSKfRRP6v9QSCHVvG9TUtOWwrU80vAwNbmf78+upUY/hoxfzoJWPI7AiEXTVZJKWd45j4HcSljnkaO2gHz6E4kzl8GG6DDolAeeOrxw/ekTJduoixZe8QB7+6jyFJnwaQl0AO00KyA8k2JCWOpfxB7gPeR0a+Kx9KjAOHTHAgxf2IgpDSEHaAhzGtzngQe4yTxVacEWEF02DUxBNP8CuR02IVUCKvA7lVVT8K2duiB1Zrbsc3NkP1dyzk3DhAc2CDOKPamilxfg0T+c0vYxxVzb7vTgfV+CFTI7x1ELYfSbroQqZM58OQEp1InzGmx0Td3CpIrHX2y64O65uSBbqCsmUaPPsdkFRuW2ph0fJJHvvScbPUfM1nM3kFump7RSyd2SEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50511efe-a713-4dae-11e3-08dc176ebc2e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 15:12:35.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tb2XCpCuEsSKiiAA2e1SMYOmNAFP6HiuwukHSWFThrRyVnyERAzU/ZXb2AoHc/K+jFIi3+tmqAcSXa3gt/7BGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401170110
X-Proofpoint-GUID: 087vxukcvrOgit3Ek01Al633oscSpxJB
X-Proofpoint-ORIG-GUID: 087vxukcvrOgit3Ek01Al633oscSpxJB

On Tue, Jan 16, 2024 at 02:45:56PM -0500, Jeff Layton wrote:
> Long ago, file locks used to hang off of a singly-linked list in struct
> inode. Because of this, when leases were added, they were added to the
> same list and so they had to be tracked using the same sort of
> structure.
> 
> Several years ago, we added struct file_lock_context, which allowed us
> to use separate lists to track different types of file locks. Given
> that, leases no longer need to be tracked using struct file_lock.
> 
> That said, a lot of the underlying infrastructure _is_ the same between
> file leases and locks, so we can't completely separate everything.

Naive question: locks and leases are similar. Why do they need to be
split apart? The cover letter doesn't address that, and I'm new
enough at this that I don't have that context.


> This patchset first splits a group of fields used by both file locks and
> leases into a new struct file_lock_core, that is then embedded in struct
> file_lock. Coccinelle was then used to convert a lot of the callers to
> deal with the move, with the remaining 25% or so converted by hand.
> 
> It then converts several internal functions in fs/locks.c to work
> with struct file_lock_core. Lastly, struct file_lock is split into
> struct file_lock and file_lease, and the lease-related APIs converted to
> take struct file_lease.
> 
> After the first few patches (which I left split up for easier review),
> the set should be bisectable. I'll plan to squash the first few
> together to make sure the resulting set is bisectable before merge.
> 
> Finally, I left the coccinelle scripts I used in tree. I had heard it
> was preferable to merge those along with the patches that they
> generate, but I wasn't sure where they go. I can either move those to a
> more appropriate location or we can just drop that commit if it's not
> needed.
> 
> I'd like to have this considered for inclusion in v6.9. Christian, would
> you be amenable to shepherding this into mainline (assuming there are no
> major objections, of course)?
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (20):
>       filelock: split common fields into struct file_lock_core
>       filelock: add coccinelle scripts to move fields to struct file_lock_core
>       filelock: the results of the coccinelle conversion
>       filelock: fixups after the coccinelle changes
>       filelock: convert some internal functions to use file_lock_core instead
>       filelock: convert more internal functions to use file_lock_core
>       filelock: make posix_same_owner take file_lock_core pointers
>       filelock: convert posix_owner_key to take file_lock_core arg
>       filelock: make locks_{insert,delete}_global_locks take file_lock_core arg
>       filelock: convert locks_{insert,delete}_global_blocked
>       filelock: convert the IS_* macros to take file_lock_core
>       filelock: make __locks_delete_block and __locks_wake_up_blocks take file_lock_core
>       filelock: convert __locks_insert_block, conflict and deadlock checks to use file_lock_core
>       filelock: convert fl_blocker to file_lock_core
>       filelock: clean up locks_delete_block internals
>       filelock: reorganize locks_delete_block and __locks_insert_block
>       filelock: make assign_type helper take a file_lock_core pointer
>       filelock: convert locks_wake_up_blocks to take a file_lock_core pointer
>       filelock: convert locks_insert_lock_ctx and locks_delete_lock_ctx
>       filelock: split leases out of struct file_lock
> 
>  cocci/filelock.cocci            |  81 +++++
>  cocci/filelock2.cocci           |   6 +
>  cocci/nlm.cocci                 |  81 +++++
>  fs/9p/vfs_file.c                |  38 +-
>  fs/afs/flock.c                  |  55 +--
>  fs/ceph/locks.c                 |  74 ++--
>  fs/dlm/plock.c                  |  44 +--
>  fs/fuse/file.c                  |  14 +-
>  fs/gfs2/file.c                  |  16 +-
>  fs/libfs.c                      |   2 +-
>  fs/lockd/clnt4xdr.c             |  14 +-
>  fs/lockd/clntlock.c             |   2 +-
>  fs/lockd/clntproc.c             |  60 +--
>  fs/lockd/clntxdr.c              |  14 +-
>  fs/lockd/svc4proc.c             |  10 +-
>  fs/lockd/svclock.c              |  64 ++--
>  fs/lockd/svcproc.c              |  10 +-
>  fs/lockd/svcsubs.c              |  24 +-
>  fs/lockd/xdr.c                  |  14 +-
>  fs/lockd/xdr4.c                 |  14 +-
>  fs/locks.c                      | 785 ++++++++++++++++++++++------------------
>  fs/nfs/delegation.c             |   4 +-
>  fs/nfs/file.c                   |  22 +-
>  fs/nfs/nfs3proc.c               |   2 +-
>  fs/nfs/nfs4_fs.h                |   2 +-
>  fs/nfs/nfs4file.c               |   2 +-
>  fs/nfs/nfs4proc.c               |  39 +-
>  fs/nfs/nfs4state.c              |   6 +-
>  fs/nfs/nfs4trace.h              |   4 +-
>  fs/nfs/nfs4xdr.c                |   8 +-
>  fs/nfs/write.c                  |   8 +-
>  fs/nfsd/filecache.c             |   4 +-
>  fs/nfsd/nfs4callback.c          |   2 +-
>  fs/nfsd/nfs4layouts.c           |  34 +-
>  fs/nfsd/nfs4state.c             |  98 ++---
>  fs/ocfs2/locks.c                |  12 +-
>  fs/ocfs2/stack_user.c           |   2 +-
>  fs/smb/client/cifsfs.c          |   2 +-
>  fs/smb/client/cifssmb.c         |   8 +-
>  fs/smb/client/file.c            |  74 ++--
>  fs/smb/client/smb2file.c        |   2 +-
>  fs/smb/server/smb2pdu.c         |  44 +--
>  fs/smb/server/vfs.c             |  14 +-
>  include/linux/filelock.h        |  58 ++-
>  include/linux/fs.h              |   5 +-
>  include/linux/lockd/lockd.h     |   8 +-
>  include/trace/events/afs.h      |   4 +-
>  include/trace/events/filelock.h |  54 +--
>  48 files changed, 1119 insertions(+), 825 deletions(-)
> ---
> base-commit: 052d534373b7ed33712a63d5e17b2b6cdbce84fd
> change-id: 20240116-flsplit-bdb46824db68
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever

