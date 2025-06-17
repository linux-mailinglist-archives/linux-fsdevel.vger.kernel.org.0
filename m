Return-Path: <linux-fsdevel+bounces-51844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C60DCADC195
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 07:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F937174000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 05:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A36F26A0E0;
	Tue, 17 Jun 2025 05:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IXA1NRmi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nQ6yorfQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6DC2673A9;
	Tue, 17 Jun 2025 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750138029; cv=fail; b=TAgIS06CUBPndu9muMe1mDgA/Chbn02KEXz5NENFX68vgnIDGTPcWbV73rhwfGCByHnQwWNN2QdFJ0QJ36Tlacwsr7QmDlJbDJ/HfIImrqT++g7iAFAflIj+I1hZGV3KDiLLXstBXsZ0Xy+R6ImwyswNUp9eu851QzsqGf0X+1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750138029; c=relaxed/simple;
	bh=+d2CC1yErCDVk7FPxh9IJyTy5+ZLgHHx3Cxhbc4M5qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mHDshKskCov73EJS8ettpnNMyCmqkvO5XtvKVS8Ti9c8dcV9WuGtb27f6H3jGS6PHlQdFkhSqG5oV6lyshoQ0tu66mv6M2S2Voc67DN54OTS2hnFrqC3fZDn/QJOBLXckXHV4gj7vcAXB2Q4qhKzFlWwl+gNE6s9SXTzzK1n1Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IXA1NRmi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nQ6yorfQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GNG0Ed025107;
	Tue, 17 Jun 2025 05:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+d2CC1yErCDVk7FPxh
	9IJyTy5+ZLgHHx3Cxhbc4M5qQ=; b=IXA1NRmiL6lq9/uD65dqIUi0TStSVHJVuW
	m+v+2bWpaoXp42VRlLK0VJgo39tdzuuM2r7eLq8PefV8Tgsqg8mWbKnKmKc6GHTU
	MGU3zmUjMkIjpf8cC3ZEAUNR5fVXZiZJa5i8gpsEswK7/59wUj7dNiKX6jACUheb
	FuED444rWttgRsyL2UU2rCqKd5e6Ks/WPgXjVFtWG0tXvbmK/AV9mydVHiaU9zqV
	vsvi4uoSeMm1a60x4o3c3fUgyoyF9u5HNcrGOaz5s6moY+MUYD6zB+G+AOJhYLho
	X6sa5sVyijGPgkhFWkQTBIW6FT+umTWvHnygK8I4bpk9IiJW9pQQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd4h0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 05:25:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55H4q66h032042;
	Tue, 17 Jun 2025 05:25:41 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh8sbt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 05:25:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLCjblOZxmX5SUP6xAZP7w/QNzLrhhFATfbM9gcQ4K/JAwwOAxxbOGNZS5HPkZ/6t4tIhIXbkvWldQAYIBUtRkbYwNzGnGiWwcDWA+Q0uSwv3K1Uc/fcQK7ABlh+XuBNjyUv6cthAIz6BMcmCA1qD7B39WDLZd5s+WslUwom1YL1PLRVag/QfmxummN6D3GnV8EfucMDkLsBK+USh8x0R1VeZB62ERg3e3aafOdWsAfiZ86rWXPzpjTuZLB/dTcOEK+dLbryKTs609CAWxx0GyrzwnZWwvGEsFDibuHQ1iQH9lfVpZGRzTNezEXCykU3oNPdY8QJFGN+KfbAyRLb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d2CC1yErCDVk7FPxh9IJyTy5+ZLgHHx3Cxhbc4M5qQ=;
 b=l0NuoXaTpEvEFruR2LCOhCV7ThtIpBfO155YtA3V4MIXKn/VEIOZpiBxt8eG45huOIMyxnasForWweyCYRl+9PIBQ3p26Jl6+r341Fq+/FRt5xhMZqQv+O3noCjEpRA7G/1eAvDxrJt5N5x3+UHZsxccnTwkC5QOR0GMU0EY+HdFcO/aZIB+XWSPiMy6/NogoXuWuTA7Y//Ijk9QEIRHUcXht93jw7R1b/zybcbm4P7QO5sDaCCd/psZgItpXA2sxnYgT1N+ITTnUUfzeyEWuf4nc5R5tT59jHCTWSDaTnCftjsTtyRhurzZQ9WdlhMBC9gg/gxBiDeSt9AQi+2Geg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d2CC1yErCDVk7FPxh9IJyTy5+ZLgHHx3Cxhbc4M5qQ=;
 b=nQ6yorfQOCRlbTLeiOMsYHOr/EoZfIXAxMABv0yjFcF/WiClpcWS/eZkC3xOYDwPepuBJf6P/evVPUTohew7sWiZFSEEh9cH3NpJ7sX0WnJZNUUocHzJAAwH7Z0ws48BIvSGBkGSkd79fO1QlVIEcozYpTdZvraE93QzIGddCp0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6361.namprd10.prod.outlook.com (2603:10b6:806:26f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 05:25:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 05:25:37 +0000
Date: Tue, 17 Jun 2025 06:25:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Benjamin LaHaise <bcrl@kvack.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        "Tigran A . Aivazian" <aivazian.tigran@gmail.com>,
        Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
        coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-aio@kvack.org,
        linux-unionfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        ecryptfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH 03/10] fs: consistently use file_has_valid_mmap_hooks()
 helper
Message-ID: <b91c387e-5226-4c5e-94c3-04e80409ed62@lucifer.local>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <b68145b609532e62bab603dd9686faa6562046ec.1750099179.git.lorenzo.stoakes@oracle.com>
 <aFD5AP7B80np-Szz@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFD5AP7B80np-Szz@infradead.org>
X-ClientProxiedBy: LO6P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: f416cfdc-e95b-4451-cf3b-08ddad5f640f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zBrt30AJQ3A99RHarmrN2YEXPXT0XaOr58V0Hf+ukD6shnKuJTYXelTGeUov?=
 =?us-ascii?Q?dkzpbEb1VrLbruz3NGJiElHi4p1txBiW8zZvxbkVPjChjaqRL5wbf2W0eKZ0?=
 =?us-ascii?Q?pTAx/KxsZE8MB+cGc2o6q7W9HpBjVDpzY06jRmofM5/vG4VYIiOPOXndQMgB?=
 =?us-ascii?Q?fcGdaKpPRhMvP62sw5+5ibPteeM+vQn26qpNBIsKluBDY8Tan+2aLMRKWTvb?=
 =?us-ascii?Q?jsw3tIbMPSAjwcXgkxJHEAqDE3hqGfMT9JckOc4yvfFyYTIY13ToSd+9vzA3?=
 =?us-ascii?Q?QTAugtRHZ5BGaWO/H8+UN0b+Du9muyKvyHokbBMwktjP6AsWrcmzZgLMMG6L?=
 =?us-ascii?Q?etnWZaHHhOVSynKySWdvt8i5aaz8BP/zRduiah1YLhtA+o3lfTyry0xDrEUT?=
 =?us-ascii?Q?Ht4fgY/KnVTgUb3EuZmcOTVreFiwRT/tKHVlEkdZTmedM5/AMdrG3JYzFc6z?=
 =?us-ascii?Q?EsW+mVY4c9FkyVH6hoRCy/xGJGmgTjf2omhQYdZJLeQFe5g+50EJ165xdwX1?=
 =?us-ascii?Q?Zn4k8QnIWF3R2AZd33wMWyEXqowANh7IKe4hQOgpysHlfTafu6iKhBcfqdJG?=
 =?us-ascii?Q?sKgGaKWf4y81xMNDqaafnkNOgk+31o1qNt+NsrtY9Qer3HGfoULgRm2UPZ13?=
 =?us-ascii?Q?BCv3o3YfZLd+n2mqz5r+TduVCeh6L/N3OOCTNfZ4MVKS0pn/pKYtPf/2vQrC?=
 =?us-ascii?Q?V/RtpqPON3369kuCyWpWpqy5cVX6BvX1DYGZ6wqlOBfZIH2O4i2qezTNCUOY?=
 =?us-ascii?Q?dNi/ujk0e+0GSEJyDFWgZsfR1WdqivViKVQk+ouA+MDD16xcKFr6c9xQB3aM?=
 =?us-ascii?Q?T95ohJfaRcmfE6WIx6uL9HkIxhUCrX2WCuz29kxAXbADB8Ax0P6qJUlp3sR+?=
 =?us-ascii?Q?wjfg89oirypdm+dUvw9yuJ4qKUddEm8fEjVYxTm42p1T3ciXLxNn7o2Fqp4Y?=
 =?us-ascii?Q?9Wl0y3IzLygD2yKe96JJKdlIIE0KPjrksVW2WztKJLHhx8SCYQ7k9278w0iK?=
 =?us-ascii?Q?ett7YiA7V9Frxg5SFqbZrHLqN/TR0GCOClGoewYZSOnHjW1SoEeIHBtlGT8m?=
 =?us-ascii?Q?ospMJyE/tpOdJeZH5ZnfqgIqOCUwQUmmfAPkWvCZxfxz6EikQ2SmhHNSB+cD?=
 =?us-ascii?Q?Rlsb1DL2j3LE3WSiNREOqBcFvyy7uERgN5SzPkY6ApTVjZQ0cnmrHlaQcm6k?=
 =?us-ascii?Q?sR3mWg7fT4RWaVQymguXu7agXPX6At9o472ePMqWParLNuboPaGX7KggV0RL?=
 =?us-ascii?Q?ABgTzyDsOAvb4mVL4iScb0c+8ejj/Y8Ty0SQdMNhvfNG2mRJf8u0Mt7IdWT2?=
 =?us-ascii?Q?3XCdFOKAO6Ipzo90uMS4MI22Dke2M79eTdLArLO63ksJqPpOKl5YsodvQpt8?=
 =?us-ascii?Q?MzDW6GtNrEWQfe0voyHIwwqhUR+WnBLetmfWwS2Ur1DZqE/5JQyZ4NzInLHG?=
 =?us-ascii?Q?yP8nE+SJmPY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?orYS+9QWp7iW3jLxh+Jg5JE6RvBFvcdn71iyYdKC4dRxZ1mQFa3s/0OpWWvK?=
 =?us-ascii?Q?VXcOQF5t58KV9T2iO16QF7LLUU8I7m2JWwg34FDbC59LomGPXEx6it48tOoQ?=
 =?us-ascii?Q?85okBZmbb3kfb/f/Coknw8GCfFz7Ngk/FOaomomKcAVne1wWjGJQXUK6jObC?=
 =?us-ascii?Q?UsASyfSnFPTrWUQkCOvZBIQl8Ca22Z/faJ05bhLOdZKuCgBTrmeOUYMxbGNU?=
 =?us-ascii?Q?mavmQfjoOuV5KkALr3I0KTbCooUYSJPRxMKZcxm1KuyAmEWSlPbM0ZYqC263?=
 =?us-ascii?Q?i6RUzfNw23Ewj7McQlJfFUsyWy1M/sjSSegecahsuLLWfA6/vfuVgbv60Xzh?=
 =?us-ascii?Q?r0WpdXncL++ldwwKxn2tBg2YKRHwjP+qNDvFJC+PYSJI5KXWYUbFDV6amYuZ?=
 =?us-ascii?Q?eDUkUCJnRmyq6yW6KpQHW47K1q6JnO9ocudrOOa66E50XzyWt4/8anoBPK2V?=
 =?us-ascii?Q?8RZCD9YiA3quv+Tnbzd4QWcr5ISvSVwXnfjfzHYQ8TT0dI7k0vntjPzOV6fT?=
 =?us-ascii?Q?OoeaFBDL7/hsa6YQ7/Mm/Ici6rDvJuJbhQAyZAHbz6ezjD/5N4me7hyg1LRt?=
 =?us-ascii?Q?q2H3bH2mvEP0BPyvJ1IseZX/hFkUvrgL7diXrssffJAI8OW0Z93bf7NzxBbK?=
 =?us-ascii?Q?4BZH/7W7U92Ct6TKkU+9JUctG2hBSjBMkbLo8DnYf9zxXoP4jArdRgfIpian?=
 =?us-ascii?Q?bYO/omJzxh3Bc1HB+Qa6tPsc0+vrhrfQZihU3BPLPs3APfOEzGA8rCh/vUkE?=
 =?us-ascii?Q?tgKJ6Zw0IHkTYammuzZ3kZzyZzN4t426KhJX67uFdqN6ceWgmd/1lA5MMVtC?=
 =?us-ascii?Q?ZRrYjDn0aY76PgQ5UBw0i8Vm590rEFtxcQe6Y/ekJjLlDeS48j2I2IKpMQ6L?=
 =?us-ascii?Q?XampdwiOjlrJf3jxMvzpE8IiqHR7992MvEevBNTrp+uYY2KD8XP4PwDqv/Fz?=
 =?us-ascii?Q?EsMyMz8H8Sbj0MopZMo70hNPZn7BegjYt8GJ1LkfhzzIGFbSP9uAY4UeKaGJ?=
 =?us-ascii?Q?2pb26wI8hVNC9Ks2kpM3Wv2arkfj9ZT1lNknHjqvAGPhZTca5SdhHGpAxJul?=
 =?us-ascii?Q?EOdGXGgAOxlDNODfCWLpEJRcEOLEFN/knJWjsFLeZhXutqVSWVu6TVWX3ouw?=
 =?us-ascii?Q?5Nagcc9oiC4QeaNVpi9YXsPupBQK/Y5slaWGqql/lqrjMVKopAWTPudxgzf7?=
 =?us-ascii?Q?yn1N6+8ekceiMQtZ2RB9P8p9aoztUE8SM1siLMvmw+h2l1mbWdyQwJt4xmC4?=
 =?us-ascii?Q?jOww3YBz2XKqRKXW+AqO7qtrOIkR9++YtqcaW8cdsfbU7E3X/vFGiU4oWuBo?=
 =?us-ascii?Q?0hLvuHKGslovOE16qGY7YpxyiHM9wktj81aWtOcnXKXw/AxKkjpKrBKpEJJU?=
 =?us-ascii?Q?utYlBWJlsjdMoOmvHE3S7aaFkYlsSTx4qrIc4+RqPeXJ+t7+htePK/DQNkBx?=
 =?us-ascii?Q?lQt2opdsKPF1uizKbzbZnTBzaPLHNAIfbwMura/4/9m190uqQpuw7wIYxlNw?=
 =?us-ascii?Q?wdQ68Z8/5lGTglAR6Gx6y5848Z9O+AC0xrPxeIBiSZa+T18in1lLKLTGZc9K?=
 =?us-ascii?Q?iCvW3tl6TexGdbezWRu9NbaaZXFQ90dXQeAZ+hkaYWTnFiKowHzupx8kX0V7?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MgQZMWDRcFNdoivYe5RNN1cGGMzMxdY0MVdwGCWIF8/FBtBF3kPtZwteP6p7IwlN7NNh17NWuLa2h+6jPurM55/j67vjmm6QW2y3ToAvX+0zrfWOj6pga/rtpcT3HqgAQ7HWT/lU1dzjeGhINlLoJQ0Uqt2EFktxO1IWEYHKzcuoqJNt+w6JksDAbvvDhY+6dH6sRijJADV3ynid9qaa3lsPmdYzV5pckakhFG2kER7cBYbqWW/fA21xE5whP4IT91+RELkc0BWZHMKmz+18B8Hr5KQplANDCOEC+0T5YjWULwXQV9ReZjHOzaX2Oc/L2OTQQuacve42amd8nUTC52it1Kw8iJTtxVIwCjN6WZcPULcovI5VSPaFM0zrHYTMMcMYqhi+doJQs/oiKIUCpMSZAkelp66ysULDKDadWcjWdBNHijPxU5FCUBrQT2y9AmESU+DqkoF4ShcKp7HaUM7VUnkf+5W5WPv95R9GOBd8b2qooUWJA0QOXa3vJ7KrKqZsIoBIzZ8FkvCdiFMBhxQyxX7xZzMC64pSY0i7qzq28p4EilD/N/LWGpdUkm+C/6qdRBduqVGxBZG2pgSJ5GXOtqy5ye6ccktxKDTKS6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f416cfdc-e95b-4451-cf3b-08ddad5f640f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 05:25:36.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z6gFvr2pcnE3u1T7nO6rKF69rkKU9MtyflIWULywbTzCJfsp6SmkaBlh2txUzflZivdjMxyqXu0nLXIeVfdTBsoKhnhCBLZt6rS9kxckgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170040
X-Proofpoint-GUID: k0h7RMa2f6F3Ie3nnmwnxXxVd3UgGZr9
X-Proofpoint-ORIG-GUID: k0h7RMa2f6F3Ie3nnmwnxXxVd3UgGZr9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA0MiBTYWx0ZWRfX33IJJYMY4w5M 9q5TuEyY+UgjC1UiZJxBn4MsTrA3H2Xnanl1vf1zIDRC1j8fs9eAOKxYc+yoo/QXjNR5DWivmgh W0E9Rs9SQWU9kFCryNtOwVdW3ynIFlTlSugCFkEZSUFBxvTqifz+D1lu+kYjcbBm7vcVaK4R3y9
 qTfQkkdBYQP5mWubhcrk8gzfc16A4IIOtR+tE1nep1RAJZD4kagQKqOTXKkY5Pm7qAbGldOxTHr gpUDzJwEd5QVmhJAjJenivhU1Zgf+u+lFksp2M/WlqGynFVa7qMuO6dSHiatPHW5yEoV25DscFl Td6bY3npJsgVvYWKSdLsNcw1aOz+icIxh2PUoVCD97xPG1upekTmPOGVKUjBuYtYZOz1I4QAP6Y
 k5ZmQ5+W1mARUrlxazlsfeYlNs2yifiuqvlDaircuAK3HF8tkcIWmt4UQ4vMR/ZZ/iOQCbDe
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=6850fc57 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=I56PMZ3PheIbLmDFx6AA:9 a=CjuIK1q_8ugA:10

On Mon, Jun 16, 2025 at 10:11:28PM -0700, Christoph Hellwig wrote:
> On Mon, Jun 16, 2025 at 08:33:22PM +0100, Lorenzo Stoakes wrote:
> > Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> > callback"), the f_op->mmap() hook has been deprecated in favour of
> > f_op->mmap_prepare().
> >
> > Additionally, commit bb666b7c2707 ("mm: add mmap_prepare() compatibility
> > layer for nested file systems") permits the use of the .mmap_prepare() hook
> > even in nested filesystems like overlayfs.
> >
> > There are a number of places where we check only for f_op->mmap - this is
> > incorrect now mmap_prepare exists, so update all of these to use the
> > general helper file_has_valid_mmap_hooks().
> >
> > Most notably, this updates the elf logic to allow for the ability to
> > execute binaries on filesystems which have the .mmap_prepare hook, but
> > additionally we update nested filesystems.
>
> Can you please give the function a better name before spreading it?
> file operations aren't hooks by any classic definition.
>

can_mmap_file()?

