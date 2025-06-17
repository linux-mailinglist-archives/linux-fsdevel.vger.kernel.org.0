Return-Path: <linux-fsdevel+bounces-51907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A17ADCF4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE01940087
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 14:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68F12E763E;
	Tue, 17 Jun 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DnFh08XP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xFyoSn3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0644D212B3B;
	Tue, 17 Jun 2025 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169314; cv=fail; b=lg1ufWk1Kn0QZGACPoqDN5P8UbxUMXyYeMUrXEzfnbsc/KVRNy6QzXRQkxBgGhlct8fcQ0E10OfyfzDpAEPOYMghT6VrRoY8V/IxS1tVy2DYqx9ey5tMTyL9Hwgo/fiJXBYaBwoyVxERvOd8xZ1i3pnSncykgYHcSlFJFc0lwVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169314; c=relaxed/simple;
	bh=IA2iOZfVybDVuSS+rMqxBzX2CYAnOjcbg+tM/v6cPms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gMR00s5qEbY5uKLt0ybvABcvVMo60yxChHTdr6Lr1K9rK9TvjJlKbPPhF8i4dtQ2dS/4eI3CbTrJ5Gimfqt1PtvGKX7aLTKXmKPQ303oNvZrdpMoKuTwTU+6CMuKzuH6YSoXrGErrWA4GIL4Mhm6p1r31RccbivhxLwTUjJAEoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DnFh08XP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xFyoSn3i; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H8tZJP026730;
	Tue, 17 Jun 2025 14:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8oKkXqWtxjgAj9B6YdYXjVyrnRlQETbPFOsHG8ye+TY=; b=
	DnFh08XP3+BLK6COLtobny7dH6juXqFHJu4JIab677hNWX8iQ+6Ewl0iQYLkoKLp
	mCvqd3wk0312uO3huxNTBhOdjM6ql9kyYQh5SYUHMHnrvkKEakwGoKPNWzZ96s+Z
	xdboxR7ldXZKuxBctFwkcssNEYpHLqzkhETN4PbCZbagf/7cfTaLI8cqT97QJdkZ
	x1rrPSo4ktuOwaAbhjsGjKuuXxh9XfTK2JleacPXNp3sYhrT2LH9iosXWaYrAXD+
	DaePRHXge1nYDy+gEntWN9ukRdCRpaF81bwk4CDveV4sOjnfUTAsPr/1s+qxdy0E
	VXippHF0Fbi8J3uf8ejEFw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914enbf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 14:07:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HD4gET032155;
	Tue, 17 Jun 2025 14:07:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh99g17-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 14:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4iGOJ6kd0LPl9wI+34gvLk/MJva4nrz2G0yyYSPnD1bn5SN/lIm5oon6DGzjoEnk4lmMeYhLNpV5V2lFd3emwo7xPSrr9Lert6i9uefUCezEpQC7/UE+rdR89B4anXQ3YdyuEqN9ZAD7XY3/ciVP6jbK3IZCaPjMj0ipAk80pr/Oy/fIWOz/EE4FIjNCeJDWJD7EZ1umbvrbAAwJj7qdraP45iYN9h7jNG/r61wETEDv6WPdNzqIgNC3qg8Kqp3mmZBn9UmeZ1oJ+NG+BMzzYmm08t/TCjS7OE4DmEtjbzHN9T5MbP4sbMVqilnvleOMDt4uMuZeVGY0muZ+GGiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oKkXqWtxjgAj9B6YdYXjVyrnRlQETbPFOsHG8ye+TY=;
 b=Oc5/XR/ZPnLjZq1qTBqE5hQBn/WPGr7A/3mONKmlN34nAHkOF5Mzwmu7bVcB8zWge4M6GYFaKfGZ7WAmFeYDeK9vPZa/5J+Ik7TsBuEi9AWSx6d4QQ0NiG1ocDNEPTe6iQAYUot17m2RTIFd+HuIrDVG4/zJhe5jKv8759xTAp6jf5R7SUYmhKsPt0lIrB5DnLNU+n3crXGUlyXL1bkqNbyBQp+fuMfDBtq5MtPDGM0Xf0ikEUBFhS6YfxBvh5C7DN4ZB+cpra6phA3ukp/qxDyL8IioVirGheieXeUyuWYYYfAaX/m+DaOSI0eoBFWRWdw56YxmZcfBFv00Sdyq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oKkXqWtxjgAj9B6YdYXjVyrnRlQETbPFOsHG8ye+TY=;
 b=xFyoSn3iAAJTET+b1KlAioNgOPztjXKrrWPMgxYs7iiMCe3jTzKvIBP+qSLlZdCBgOdSlPr8r2OFumdKc83vj/DtNd5ArSBaxXZfcrEEDBJWw2tDDZO2Wqty66mz75Q95RDM+OkWrD45olbl9YQQ1PndWgyjc5NMdcqQZf2ZsXM=
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d) by CH3PR10MB7308.namprd10.prod.outlook.com
 (2603:10b6:610:131::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 14:07:23 +0000
Received: from DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::1c40:7ef9:414e:f765]) by DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 ([fe80::1c40:7ef9:414e:f765%5]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 14:07:22 +0000
Message-ID: <e20adc50-7c83-4bd1-aaff-799a5debdfbe@oracle.com>
Date: Tue, 17 Jun 2025 09:07:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] fs: convert simple use of generic_file_*_mmap() to
 .mmap_prepare()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe
 <axboe@kernel.dk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin
 <tursulin@ursulin.net>,
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
        Gao Xiang
 <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
 <dhavale@google.com>,
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
        Martin Brandenburg
 <martin@omnibond.com>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Zhihao Cheng
 <chengzhihao1@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>, Carlos Maiolino <cem@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox
 <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <c7dc90e44a9e75e750939ea369290d6e441a18e6.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <c7dc90e44a9e75e750939ea369290d6e441a18e6.1750099179.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:610:b2::7) To DM3PPF35CFB4DBF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c1d)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPF35CFB4DBF:EE_|CH3PR10MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f5e2d1-b0c7-4b93-2740-08ddada84741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1MwaWdxNEhHWDNETWlqZ1NsMHp1RzA3VkQ1KzE4bSs1NWYwQjZmVEg2d25i?=
 =?utf-8?B?UGJqS29GVkEyV3pKeW5FY3RleDVqNTNubzlhNUZqLzlmNFdRRy9OeFR2TTh1?=
 =?utf-8?B?bjU2c3ZCMnZhSGtKQTkvSU4zSnRSVFQ4ZVFDWEU0ZytoYUIvM1cwMjZIeUMr?=
 =?utf-8?B?VFRkZ3Yyd29SUHhwYm1lcWFsRXdYbjM1T0ZyR3ZiVGlsc0NXUUtvMVYyQXdB?=
 =?utf-8?B?Yi9BQkdRbzROUnFmQWpMSTduV0VjcXpEQ2pRTE5rRSszVXI5OUJoNzE3ZWMw?=
 =?utf-8?B?L3J3d1htenZzRUd2aUc4UHhabi9ZN1dPNzh6bTBLdm5nOFhObTFoSjJxM1d5?=
 =?utf-8?B?SDhNSHJNbkFyMmpLWWdNcmRIQ0Z0bEQ2dTg5T1ByYUlVRndzWkxOcDA5RFhn?=
 =?utf-8?B?cFVBbUZ0MDJkaWV5K1BReEJITUl5aElleWQ4SUtpRmgwcDJjOTdHb1RuMDdB?=
 =?utf-8?B?ZndwOUZDMzZ4eWF0TGNtejdWWEJQQ2hIVmhlNVhXdjZ0cXEwNEIzTFhhQlBq?=
 =?utf-8?B?dER6TUdIT2RWU0E5WE9QVWt4bzRUYm03b3ViRW05V1ZHYWxUb3c2QUJOTHFH?=
 =?utf-8?B?MjYwM0RwTjlsL0RPZEdwWHg3VzQ2Z05VKzJRMldGa2Q1SCs2YkRJNjFTOGdl?=
 =?utf-8?B?L2hOeXBqc0VoTG9TYVJ6Ni92eHJtbDdta0ZSUldlNUN3cVRFM3BlbWNPRDQ3?=
 =?utf-8?B?Y0tLYmJ2YlREMkkrcjNJdEZ1Tjg2M1JNVXlQMUhlaTQrTHZHb1dNMnJBL25q?=
 =?utf-8?B?bGRZZjR5MFl6aWxGbjgwRk9FbWdxL0lzbm02eGxkSDRRSlg2QUpkelVYN1JE?=
 =?utf-8?B?RHR2Q1g1bG5xR3NxT0RSOHNEeS92VmpPUk5MV2RXQ1VuT2E0OXQ1UmFSZnVM?=
 =?utf-8?B?SHZUOUNNcE82NTRhSFZBWEdrejNWS1NITkc4OUZFOElOcGFDaDJHZWhRcjBw?=
 =?utf-8?B?Mnh6c0ZsM1JDTTNlZGhhWVZ0bVI5MnpwemhzQVZVMXBGMG92T2RZU2FwclFJ?=
 =?utf-8?B?NlQzb1RQc1JPQ2E5VDVDVmZRL2JKdHhEK0NNbDFpRktBbEFPRXE4Y2RPeVdu?=
 =?utf-8?B?WEdya0poYVpiQlpBaDlOL0lHMEg3N1pzNFpsRVFjL056M3dOcXpDTlZUOTV0?=
 =?utf-8?B?UElJdVVKUXR5bkxZSDlYMzUzUGxjK3hJdDFGTEtSZzBtblNVaDVBMHlHejZv?=
 =?utf-8?B?VkhTOXpTVG5kVG9JZkdNR1o3Z2pmMXJHSUpSdnVCcDFKd3RWbkJkVUE1Nkty?=
 =?utf-8?B?WkdVZWhDVlBBd0VNVjZqTzBONWE5Y3NiNzVvRHdCczI4SHpHc2JZckpGVHpr?=
 =?utf-8?B?OVNQMm9Ea0RhU29Ea1VZWkM1RDAvL2FMcnE4Z1hLamV2eDBLY0lKM2d0U2V0?=
 =?utf-8?B?QTF3Qlp3QUpBdnROK1o5WVlkMXdBYjJ3MkN4Q0FMT1RKS0RmQTNHbHN3ZnFk?=
 =?utf-8?B?Rm5iNW04V0JiQ21NWGFQdlN6SWlkMTJtN0tPT3hvU0c0TlpEaFZVQjA5WENM?=
 =?utf-8?B?S1dhUVNZdisxZUd4UFNaazNrNXNvbExPOXlLOHcrcjNBczZ5YXRCOE4yMDI0?=
 =?utf-8?B?TXZodUpyNWNHU1ZZWDZwZ1NEaTE5U0dLclhjblYzNUUveDRkeGhNU2ZEU1N6?=
 =?utf-8?B?by9TSlU0Vm90aXdaSkx6Mm9yb0I3WjJ3TFNySEJXY3hRVVBnL3VURzd6YUgw?=
 =?utf-8?B?MCtPS2xtQXZ3RXJ5S0I4VVF3bk5GU1JMR0lNVWd6ejNQUzdwb1liV0hWUU5P?=
 =?utf-8?B?RmE4bGYvMktOSGxRNk9zYW5NT0g3MTFXcTByblRWRWpDR0lPVjZuRjJTUUkr?=
 =?utf-8?B?OUlQay9MMnpqYUpqdmVVSHUwMisvMW96RTVUYjgwQlQyM0J2ZUpLN0xsdXFq?=
 =?utf-8?B?bmU5SC9ZQWdONWorWVNONnZ0NndhUGZPVVBiTzV4ZFRMbkpySHF6ZkdtN05Y?=
 =?utf-8?Q?2TVQFSQQEGA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPF35CFB4DBF.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDRCY0wvVnRNUnllRGJwZ2hqcmJpTHhweTdlby9PNjBhQjJkbmxsV0RKc3l0?=
 =?utf-8?B?UThlRHcvTXhoNHVmV2RVcUpkaEhHU2FmenZDb3BvZnF0RzZnSzRHTlJtVmcr?=
 =?utf-8?B?WVlYU3BkSS9tQWYvR2NRSWsxRWMxYkNOV0h4U0FvVjA4UHB4R0Y4NW5ySDl1?=
 =?utf-8?B?ZUl6Q1FlQ1YzYXpRckxiUHdwMkVEZit0dWlLc09aUUt6amhNSFRBSTNQTTlk?=
 =?utf-8?B?RFgrZEJZL0tlUUZFM1VpSjkwV1g1VFJpSVE5TDhQdTFlZllJejl3RGxueW56?=
 =?utf-8?B?OFVGOGVxWm82Qmh5WnRJZXJxWEE0ZGZJZ2k5cXFPWFdyTTZkaVgzV0ZhQ3Mx?=
 =?utf-8?B?TVEzc05BajhHMWtKSXAwQzV1aytFVzdoek5rSnNpUmhNTm5SejAwWFgvNDhu?=
 =?utf-8?B?OUlOVlYwajNEWXNSYmQ5YjN5aWxlUlVMdmVyQnpWdjdYWFYrV3RMNTBOMWMr?=
 =?utf-8?B?TCtYWERHNXhMY2wvaG1BWkRJZUJ4dHZaSy83UVo5ZWlkWXdFQmMwN3dQRHFl?=
 =?utf-8?B?NlVKV0ZkcURJaHZ4RXhSQjBVT2pZc0lZaytKaHJhWTZEcEVYYXN6VkV3TEhu?=
 =?utf-8?B?dnF3L0pnSDZKTjI0d216MEJnM2dhNHpIWkdQMmUzMHVpaFZJYkdnM01rV1ox?=
 =?utf-8?B?cDc5SjFZNlQrVGlURTg2UnhSajJ4aGdwcG9zOEdVNTlzZnczRUFCMlI3TXQ0?=
 =?utf-8?B?dlBDMzJZL0JHTm1NQzQ2Q3prZlZDNEY3R2tIUGtVaHI3TmF6ZWt6U09nVjYw?=
 =?utf-8?B?VzJGZjhPMVl0UFluVG5ZalVYUzh0QU90a254VlladHZBc2d4cmtXWmxRMVVU?=
 =?utf-8?B?ejhDdmNsdXAxMHlLN1JoK204eG9SV3M0YitIeXE0YWRKUHhwVWZxa2JZOXo2?=
 =?utf-8?B?Ukt2NW5oWjhRamY5TVgxVWo3d3orT29XQ3kzUGtnTUNCc1hudHZLQTRRTHZQ?=
 =?utf-8?B?SjBOTEtXZmhuZVNqRGIzOVhCVUIxdVNsTy9YWDlpSTM0a2lKeDhaY2Fab3V0?=
 =?utf-8?B?RXBNYitwWFNaamt6Ymdxcm5taGY5bXRIU2Y3VHM4UjRFL21ocXpPL2xRclFL?=
 =?utf-8?B?cVhFcTRZTmUyOGVsUzVLVlVLWDVzNHFXWmFIWnRyZlpHei9RbkpVSXpYNnRK?=
 =?utf-8?B?bW1wU1V4QkJPWVdRcDVLWXVWb2N4bVdZUmdMVTNrdE1UdVg4S0tXQVRybUsx?=
 =?utf-8?B?Z2F2My81YVBZT0ZMSVp2V0grd0ZvMVZ3S0VKYWxKRkZXUHFQN1F5QVhTR2NI?=
 =?utf-8?B?NVNaZGpDSVhma1JXbjZQWjcrRER2ZnowRUN6Z2tOVFFtcFJLZy8rQURrdEs1?=
 =?utf-8?B?cmo4cEgvUk5COTRWRmRUV1dQcUt4VHQyVGJaZEJ1N1pkVVFJTEVpZWd4U3V3?=
 =?utf-8?B?TlBFOEJNc1JIS3BsOHBMZ3FDa3pwdmF6M0NIUkVTaHlWaVFvNVFPYXBRUk9W?=
 =?utf-8?B?OUNxVys0SThTUTExTE1uTzlpbktjYlhDbWp2TnRxbWs0YUNwQlI3NTBwQU95?=
 =?utf-8?B?SHJMZUxSQW1BNXV2RVBrMmYzb2NEVFpvcUtOMXd5Z1ZqNWcyTEF2TlFLNzF3?=
 =?utf-8?B?ZnBOOCtuZWY1YlNZdzBtQTdCakNhVTUwdjJ5VGFRbVppV0o5bnlFN3F0WEYx?=
 =?utf-8?B?MHh0WWFGc2VrbGZRSXdoNnhRMU1nNW1kaXd3dlRaNFhkR013ZmxINW40TGUz?=
 =?utf-8?B?TGZTMEJIY01pUUJWeDlmcG93dDJkWUpRUDBBR3NhNnVOZ0VVcmUrZjlqV25W?=
 =?utf-8?B?SkJZWHZGdmllK3pRaEhsSkhhT0pST3hPaGs0VWhuMWhORXdyWjAxMHFxVE5G?=
 =?utf-8?B?YjArdkNtTnRDYlBqL0t4ZnFsYmZzN1g3NnBNV3Nmd3NZN0J5NW9aWHBNNmJS?=
 =?utf-8?B?ZEJkdS9NblVwSUErLzJpZ21BVmRQeGM5WXE1bzN0b3c4dnNNOERNTGhQc3Rp?=
 =?utf-8?B?eHJwRkh3c2dEQ3o3eDFXcS92R0huSWN5emNUZm96OWlSZ3NPL3NRbm1WZk9F?=
 =?utf-8?B?WW9MWUkybUpsR1ZOYjB1SjFIck80VGJyQnZyb3Jmb2Zwb1dkdm5TUTN4SkNy?=
 =?utf-8?B?RVFoRk50K0o0VktWallCMlp5SmlQMVRMZmx6cnM4dEJFaVdnY0IyejRoMUFt?=
 =?utf-8?B?cHN5RTJ2UHQra0RDcmgrRE1jUEQxSzZzTnFZczR4RXdTd2dTNmM0cjY3Y3RP?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8sDeyZdz4JzHr5nwNZH6GpVkAU0r0hVq9TqLSGrYzQwTxn1Zn+k+sEv96jdUw61XJQnr3YthOKB9s/b1DEwzTokEGUBjMsCTFBQK7tzbiHd6SzoWNkpNPRZJgRzdLo2aoRCYIv8nwtXmD+MCOFaBqLCNsJWLko/cbobwCiQd4rm11gi/Diwtr5ELlkNj5r99U6KhpS30rkliq5mp5MnzQSxgfBR2xuFu8a7Ak6ie2Ihe0quPPkKvghXtlnib7bgiAthYPczXDSVjAwk+FMAk92CPFyZWUj6sCp9+ur2d5H1mtmSa2UWmojy92EcLHws8RoCGztUou4Xx8s8krMX0zgBwVFwG+IGN9vfxUouw9okUbgu7HLb+7VxCDjGKDrXbB8ogoE7lYAthuyH5w4dVoVcpvtrvLXSevQmTTCbGc3h3iKOQaHs3i92fBAmiuiLjmpcKkWPJehfr7vidagvqB9m/gbcCudQ/tRAq9MWDvV737iVpn0ya9moHa563s5F7g2HDrLVAxLdoOeduGMEFo7NCBCBrYzOmH8O/9PGiuyNwwhUv/Zh1uwqneKUjjhKGj3IksRW526E1t2CCyDt6rNKsu5iRQEQqfqvY8r5Ghpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f5e2d1-b0c7-4b93-2740-08ddada84741
X-MS-Exchange-CrossTenant-AuthSource: DM3PPF35CFB4DBF.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 14:07:22.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmVfAV/JcEikiGaTEPi20uzuoRXu2BEmrPuh9jssYmB3TR40bpbTRAa/bXHAYZZKSBaMAE4lR3tPu5ARO3zCsfnjk6BbTxdM+B5t9ZGJAL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEwOSBTYWx0ZWRfX7On/xT9a8v4W oJrMJU5BnhI1BCunh5Qje7bpmJN0YvYdSSST6/XNW43WHdt/BjIpA8dKW3l+ZENtfoPDZM6xbZ5 /VVnvfg3TLoFI+03e45EMKiqoKk4O6JIdYjzzNvkvGJmT06Rr8Otd+Wmx1wy1bZ3YsLX4sxsE4v
 JC+9sJ9KfQyWRuaJGhxgrEEL6hUflspIZVWWBhgtIjWX0Yh7J58r7+qVucUiQTA9D7WGc+h4SzS T60xaJO3p3j9vT+KyZcAwdXrrEoqCklwc9F18aSqGh8L00hV5/QOuMZlK7LlpIDrhBIIJS7fOHg v15nQ7mub46u/0eLI3FtvTiVGoyRad0aBJt2NqzBZ3amVPxQcxpWqgRCWlSH5ubvjb8Vvh2evEM
 WrmkETmw3j37l6z0n7K37lRyGM+CJ3Sa7blQQiAaVvybx15TdQ4KJ8c8QZc4FjP6L40wW/fW
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=685176a2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=o5G-qmDkIs9ic1zT-8QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: c5jScpWt90H_VoAUxnID3wprGfg2J8fU
X-Proofpoint-ORIG-GUID: c5jScpWt90H_VoAUxnID3wprGfg2J8fU

On 6/16/25 2:33PM, Lorenzo Stoakes wrote:
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), the f_op->mmap() hook has been deprecated in favour of
> f_op->mmap_prepare().
> 
> We have provided generic .mmap_prepare() equivalents, so update all file
> systems that specify these directly in their file_operations structures.
> 
> This updates 9p, adfs, affs, bfs, fat, hfs, hfsplus, hostfs, hpfs, jffs2,
> jfs, minix, omfs, ramfs and ufs file systems directly.
> 
> It updates generic_ro_fops which impacts qnx4, cramfs, befs, squashfs,
> frebxfs, qnx6, efs, romfs, erofs and isofs file systems.
> 
> There are remaining file systems which use generic hooks in a less direct
> way which we address in a subsequent commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

For JFS,

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/9p/vfs_file.c        | 2 +-
>   fs/adfs/file.c          | 2 +-
>   fs/affs/file.c          | 2 +-
>   fs/bfs/file.c           | 2 +-
>   fs/fat/file.c           | 2 +-
>   fs/hfs/inode.c          | 2 +-
>   fs/hfsplus/inode.c      | 2 +-
>   fs/hostfs/hostfs_kern.c | 2 +-
>   fs/hpfs/file.c          | 2 +-
>   fs/jffs2/file.c         | 2 +-
>   fs/jfs/file.c           | 2 +-
>   fs/minix/file.c         | 2 +-
>   fs/omfs/file.c          | 2 +-
>   fs/ramfs/file-mmu.c     | 2 +-
>   fs/read_write.c         | 2 +-
>   fs/ufs/file.c           | 2 +-
>   16 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 348cc90bf9c5..2ff3e0ac7266 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -516,7 +516,7 @@ const struct file_operations v9fs_file_operations = {
>   	.open = v9fs_file_open,
>   	.release = v9fs_dir_release,
>   	.lock = v9fs_file_lock,
> -	.mmap = generic_file_readonly_mmap,
> +	.mmap_prepare = generic_file_readonly_mmap_prepare,
>   	.splice_read = v9fs_file_splice_read,
>   	.splice_write = iter_file_splice_write,
>   	.fsync = v9fs_file_fsync,
> diff --git a/fs/adfs/file.c b/fs/adfs/file.c
> index ee80718aaeec..cd13165fd904 100644
> --- a/fs/adfs/file.c
> +++ b/fs/adfs/file.c
> @@ -25,7 +25,7 @@
>   const struct file_operations adfs_file_operations = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.fsync		= generic_file_fsync,
>   	.write_iter	= generic_file_write_iter,
>   	.splice_read	= filemap_splice_read,
> diff --git a/fs/affs/file.c b/fs/affs/file.c
> index 7a71018e3f67..fbac204b7055 100644
> --- a/fs/affs/file.c
> +++ b/fs/affs/file.c
> @@ -999,7 +999,7 @@ const struct file_operations affs_file_operations = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.open		= affs_file_open,
>   	.release	= affs_file_release,
>   	.fsync		= affs_file_fsync,
> diff --git a/fs/bfs/file.c b/fs/bfs/file.c
> index fa66a09e496a..6685c3411fe7 100644
> --- a/fs/bfs/file.c
> +++ b/fs/bfs/file.c
> @@ -27,7 +27,7 @@ const struct file_operations bfs_file_operations = {
>   	.llseek 	= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.splice_read	= filemap_splice_read,
>   };
>   
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index e887e9ab7472..4fc49a614fb8 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -204,7 +204,7 @@ const struct file_operations fat_file_operations = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.release	= fat_file_release,
>   	.unlocked_ioctl	= fat_generic_ioctl,
>   	.compat_ioctl	= compat_ptr_ioctl,
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index a81ce7a740b9..d419586d668d 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -690,7 +690,7 @@ static const struct file_operations hfs_file_operations = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.splice_read	= filemap_splice_read,
>   	.fsync		= hfs_file_fsync,
>   	.open		= hfs_file_open,
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index f331e9574217..0af7e302730c 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -366,7 +366,7 @@ static const struct file_operations hfsplus_file_operations = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.splice_read	= filemap_splice_read,
>   	.fsync		= hfsplus_file_fsync,
>   	.open		= hfsplus_file_open,
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 702c41317589..bc22b6cc72af 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -382,7 +382,7 @@ static const struct file_operations hostfs_file_fops = {
>   	.splice_write	= iter_file_splice_write,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.open		= hostfs_open,
>   	.release	= hostfs_file_release,
>   	.fsync		= hostfs_fsync,
> diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
> index 449a3fc1b8d9..a1a44e3edb19 100644
> --- a/fs/hpfs/file.c
> +++ b/fs/hpfs/file.c
> @@ -255,7 +255,7 @@ const struct file_operations hpfs_file_ops =
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.release	= hpfs_file_release,
>   	.fsync		= hpfs_file_fsync,
>   	.splice_read	= filemap_splice_read,
> diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
> index 13c18ccc13b0..1e05f7fe5dd4 100644
> --- a/fs/jffs2/file.c
> +++ b/fs/jffs2/file.c
> @@ -54,7 +54,7 @@ const struct file_operations jffs2_file_operations =
>    	.read_iter =	generic_file_read_iter,
>    	.write_iter =	generic_file_write_iter,
>   	.unlocked_ioctl=jffs2_ioctl,
> -	.mmap =		generic_file_readonly_mmap,
> +	.mmap_prepare =	generic_file_readonly_mmap_prepare,
>   	.fsync =	jffs2_fsync,
>   	.splice_read =	filemap_splice_read,
>   	.splice_write = iter_file_splice_write,
> diff --git a/fs/jfs/file.c b/fs/jfs/file.c
> index 01b6912e60f8..5e47951db630 100644
> --- a/fs/jfs/file.c
> +++ b/fs/jfs/file.c
> @@ -143,7 +143,7 @@ const struct file_operations jfs_file_operations = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.splice_read	= filemap_splice_read,
>   	.splice_write	= iter_file_splice_write,
>   	.fsync		= jfs_fsync,
> diff --git a/fs/minix/file.c b/fs/minix/file.c
> index 906d192ab7f3..dca7ac71f049 100644
> --- a/fs/minix/file.c
> +++ b/fs/minix/file.c
> @@ -17,7 +17,7 @@ const struct file_operations minix_file_operations = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.fsync		= generic_file_fsync,
>   	.splice_read	= filemap_splice_read,
>   };
> diff --git a/fs/omfs/file.c b/fs/omfs/file.c
> index 98358d405b6a..319c04e63964 100644
> --- a/fs/omfs/file.c
> +++ b/fs/omfs/file.c
> @@ -332,7 +332,7 @@ const struct file_operations omfs_file_operations = {
>   	.llseek = generic_file_llseek,
>   	.read_iter = generic_file_read_iter,
>   	.write_iter = generic_file_write_iter,
> -	.mmap = generic_file_mmap,
> +	.mmap_prepare = generic_file_mmap_prepare,
>   	.fsync = generic_file_fsync,
>   	.splice_read = filemap_splice_read,
>   };
> diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
> index b45c7edc3225..b11f5b20b78b 100644
> --- a/fs/ramfs/file-mmu.c
> +++ b/fs/ramfs/file-mmu.c
> @@ -41,7 +41,7 @@ static unsigned long ramfs_mmu_get_unmapped_area(struct file *file,
>   const struct file_operations ramfs_file_operations = {
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.fsync		= noop_fsync,
>   	.splice_read	= filemap_splice_read,
>   	.splice_write	= iter_file_splice_write,
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0ef70e128c4a..80fdab99f9e4 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -28,7 +28,7 @@
>   const struct file_operations generic_ro_fops = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
> -	.mmap		= generic_file_readonly_mmap,
> +	.mmap_prepare	= generic_file_readonly_mmap_prepare,
>   	.splice_read	= filemap_splice_read,
>   };
>   
> diff --git a/fs/ufs/file.c b/fs/ufs/file.c
> index 487ad1fc2de6..c2a391c17df7 100644
> --- a/fs/ufs/file.c
> +++ b/fs/ufs/file.c
> @@ -38,7 +38,7 @@ const struct file_operations ufs_file_operations = {
>   	.llseek		= generic_file_llseek,
>   	.read_iter	= generic_file_read_iter,
>   	.write_iter	= generic_file_write_iter,
> -	.mmap		= generic_file_mmap,
> +	.mmap_prepare	= generic_file_mmap_prepare,
>   	.open           = generic_file_open,
>   	.fsync		= generic_file_fsync,
>   	.splice_read	= filemap_splice_read,


