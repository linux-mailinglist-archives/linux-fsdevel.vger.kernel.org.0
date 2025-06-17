Return-Path: <linux-fsdevel+bounces-51904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F0DADCE1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6791699A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A33C2E2676;
	Tue, 17 Jun 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ao8CHT1W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G8tmWYJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A082DE1E4;
	Tue, 17 Jun 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168083; cv=fail; b=KYCjBOtIPLzvcPWzMRpj1xTHm0buV7m+kosn5OgtfGCcRYJMODMTaJDcIZ1g091ZHol9Xy+mkxZYR2LnuljzG/4oHOOEMBIRH7BrhtqD58JTrcMSwJSwZC7J79mqsW1+C3A0dzB26aBiC59EkE4CaEhKNKkjJ1jl2KfvHgfxwBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168083; c=relaxed/simple;
	bh=kFDBLgmviF03k4EAGDeEWTa82BAKv5Wv8eqmL5b5KQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FRfmwQqsjw4rV5rd0zDFrnLdXK4hZu3QpQ0GWcv8j75zuXNzEsilziwh8q1D4iwkN1hvTFgY7QNI0gIfolvSyFtwHQMrJBk9GsiH+OaMY0fVktnZVq+W4FBwFCGCk4/108WNaxh2k1u3Td8x2/m0yT88Uv0FwG28V/MeWJb7ntU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ao8CHT1W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G8tmWYJa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H8tYrU023871;
	Tue, 17 Jun 2025 13:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kFDBLgmviF03k4EAGD
	eEWTa82BAKv5Wv8eqmL5b5KQE=; b=Ao8CHT1WSzNpw+sC1tpleYQ8KbuZ/URTmX
	MHCA1oeiD+zmwaT/MjyyXAOjQ2W51pFpci99potCcwEp7Zv5H7gUdWqAhw6aPl5C
	8tcXENpJ4Jv9J75ZQa75Mvm2Mji5pHWIe6AUBp86L/Jb9HaDFmdim5OLMg9AqAEu
	XydZTVfGsfkx2MiMarSJafb4YLNH7ayS9eqh5M8V9UBNMXNp5V5PJ5ziRaWF5Qge
	oS7tq39vWB1AedKcqhloPMr68qa0tu6ZS68TQJ2jxVoOwtG2/b4a5uGHNxBUXknE
	QKdPAWFOiDzXWC/CsLpHFT/Xsp6gADleAv6Twz9aUJ1SZgP+8+Rw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv558wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 13:46:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55HD9c5I025973;
	Tue, 17 Jun 2025 13:46:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhfh0ht-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 13:46:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1iYW18VM9RtMgYuw+KjcSUL7oaoFzdb7XTxILLYI14x+Pc+sZ3ebaoS4WJ5gEmbKIohqxGSegBcls+JF9EDJLPDC9G6FLtvBRC+jLeIKstdq6GA6k4qAaT2YDZcp7kB/50k4XBnnct3INqLVWMW53CS5z3qFBzcpWdQWfCWTXFxIr/KUu+QA91j/fmxAf5kv/UmX2/19YXeQ+rRFnyUnS08Iu2PJG5imEF9pvlh7nzdtIrPEZzRdTZ0SgUK1gQCYdKngbkttlwCdpY3KCzudLsmEv5BjKZIH4LaApowdDLvD+6qn4OiOVkVLHWhFYRVihaFVF6EP8pS+VIuz/bxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFDBLgmviF03k4EAGDeEWTa82BAKv5Wv8eqmL5b5KQE=;
 b=c2okbzpmgRpsL8MloNwnoO2I0e9gVzkA48+KeHvd8iJV8r7xoOtuyzzdstWJ5m6xbYbKZZlm9CIEDPIqkI74Ye6m+K1NxY/TqrM940crP4OnQGIhOVoRMh7qdZWXIRtrRPDiRzz26v83QNdqe5GVmvFYFa8WkF7DwJ6C3wGe2+RfXhrAE84fMJVzowSR+bSnQh9BDBdQuGlvwbc6EsH78/R5IvYYiDoMfKlB12oJYq5ZszUhRrYbqmNiXfaTkbsbbm81/hYUc/dhJKNnu6I5DMpMMWr4tklxMzZyz5vYh5DeE3uMOcoqcicF8TUT/zp2BREmKLSTnxQNzwtgdHm9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFDBLgmviF03k4EAGDeEWTa82BAKv5Wv8eqmL5b5KQE=;
 b=G8tmWYJaSvLtJRQ22lknqb5+ycBkTumRSi2egVJVy3moFJ0qv4zZ9LacL6TuL44UU6YNteWp/pmmNwL9KD+eMWFZO0mHZWgCEkGIBwKZnMfHVmzz/Ndfh67smqUo8LAncMdGteKqFbyie+RIr4nKG8sVqLZfN3v5k02Eyl28Mhg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6125.namprd10.prod.outlook.com (2603:10b6:8:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 13:46:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Tue, 17 Jun 2025
 13:46:48 +0000
Date: Tue, 17 Jun 2025 14:46:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 00/10] convert the majority of file systems to
 mmap_prepare
Message-ID: <45c1da59-357d-4084-b4e6-98285f88f99d@lucifer.local>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <20250616204149.GK1880847@ZenIV>
 <92cd3a83e5c244a3e4a5afd5af61cfb3f8962338.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92cd3a83e5c244a3e4a5afd5af61cfb3f8962338.camel@kernel.org>
X-ClientProxiedBy: LO4P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ca3715-97b0-4d5c-f2a4-08ddada56840
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?x5GC80u0pByI8wnXI52yeQTMz7Suqn5Ijd7ghoOAKX/LojPUrLni7jAv0dp5?=
 =?us-ascii?Q?KDfbf88mcc9exzPHFJgiAXKZTmcPCGYUXuQXYAdilbKfJofuKbWQ0Kk3a09u?=
 =?us-ascii?Q?uRoviPMUTBFz9NITuDQhWXmFwl7dx22L/I80cTlvKpR10BSVNmM/c2/LDSi2?=
 =?us-ascii?Q?Fn+oFPPWk8pQXWaE0nTHE1fEFVTv7CQV0pvvHvy3EJUepWhiZZK6WIlzWGH7?=
 =?us-ascii?Q?xMjgM2DBqpxUKBhF5hnRaV7/RWD/cZBHHA7kqYVw6bIPg2n1iNVvHNKzULFa?=
 =?us-ascii?Q?XV2VtSJSQ+clsV6iKCCA31SY1+2KFCCRNp1OEDF/VnjqSemOZhMJfChlHgIa?=
 =?us-ascii?Q?AsxKRTEV9Jz2r5tuSU+d5J74vwfYMtP9bi6dx+kCCep2bQ/ngLP1TPp9oYDN?=
 =?us-ascii?Q?XRtmIOsnu5T2gkUKe/HOwTQ3XVa6SB159nzFCrrfY/r9JoMOH8JTsP1i57M3?=
 =?us-ascii?Q?pL5hSCFgpe3i1iOfGbCpGu5WsiAoVZeIt0A8RLhysY4cDpDCVKZ0XF8r4NRf?=
 =?us-ascii?Q?ApI2fGI4cosuQ7dFs2IVOfZgKk500WpCumrdCpSecGuiSD+7pu7pJUTUlmZ9?=
 =?us-ascii?Q?pSK+OlpmjAEEQZXWRCZOV18Q6hNHDc/tMglPaqJCh3gJy09oPCdHr6RwUOTp?=
 =?us-ascii?Q?eH7AB44EOfP4kLn9fUbqmXjj3Xd+Jg2c46pRTmLKrvwRxWr4uwxLZuUGYG5S?=
 =?us-ascii?Q?PnDlnnTmBCti6Fmn/5qMc99H7Ka4vDoIQvtZr0pRImYqCS14RpQH3VybNPdf?=
 =?us-ascii?Q?Y5pAMNn54IDYqepFLj2/F1/I/+DgFqaSUWiqxBegMgDbO6yVcQRxvVD3+iQS?=
 =?us-ascii?Q?uj/Z+j+4UdAM1Zpl9QTST4gac8IIkkGOV0t4jfiYVz/uXzoMC5igZhttXc4I?=
 =?us-ascii?Q?ceL0Z8ANXDuEJ4FijgS5dv/0HkaO2QK48C4aP0cQjLvsLVe5NTKmf/4TFcFP?=
 =?us-ascii?Q?698zKWR1FQonYcZqHdH9V9PIePOQDu158OgA/2GnnpvsdtRrG6L/2iGY8r4A?=
 =?us-ascii?Q?VkLYZVsZg6cWd48ECmCkPxnJXCaJvb2UOa/MVgyzDBFp9s5tpIVXQlshPZ+q?=
 =?us-ascii?Q?1evYBWQi35fzUb9wAsznjrXyKj5Vs1nlPCAT3WUJaqT2bb+/EeL+HIf6sXID?=
 =?us-ascii?Q?SQmsQsIWzHV0XpcSzX6gDYBVvXiZKg7rq982PvrmsORXt1GV0vG4HSQU5Aj6?=
 =?us-ascii?Q?0WVk8ze/ZmtJ6fQj1w0NS0nZCFTSneHCxChDVtgFX4MPED81GglQ9m+mK+qi?=
 =?us-ascii?Q?DZdoWL05EHuEOoQeSTfg5PH+x8g8yK3grxBkgX72KEtxty6CeeoUN4vPiKqf?=
 =?us-ascii?Q?TrrsfWLwRU6Zo333dBnUWuETrweTCxvLLAyN4YJjxR9kAayGrqszcYr3rGV4?=
 =?us-ascii?Q?wuhnr2uJZJBoom+/Iaa1nnHQu7oSH1ZFwo1Zp5MbRXPj5zBHljJN8xE71+sH?=
 =?us-ascii?Q?HipJMQ8MObI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?tChXKkvgbqB4KqhkZs9XL1A0X+3B6d7YIjMUayfzCYd2mhMeauUgrK8rWl6T?=
 =?us-ascii?Q?KNCAQVQIzsZipEK3dgiTkuZ8yzjhfAMYSftGR4wrJ6IXyCXhvhLklJrnbfB8?=
 =?us-ascii?Q?BcWLca1rEX9uao7V5L1sfm0U9E0bXgBoMTwUUNTmyOkruns3zCcpQeEi/Zw9?=
 =?us-ascii?Q?xFJjAOcqXA9tIhL2ZZVZ1i/ulDu1AURXzVMG7uSJcGnc4wKQbixvQgsegMmM?=
 =?us-ascii?Q?3ih85lHiMwTEJbUaHCrlqQMsruN4Gt12kMwSJLks0G/Unetz3GMVRscG22au?=
 =?us-ascii?Q?wsGPwcOyuqH2DhSbHN4LbcyZ0IiYAK4Df+6z6t0g3uBrNVV5P23YWROY6TuK?=
 =?us-ascii?Q?bTfO6H8MR5ljbNETgT4Tjh1/VcUlkKAbk7i3A+dvaz1NAyWitMXTiaK0qM+P?=
 =?us-ascii?Q?bxizuocav0DouNRFHK+Uuzgl4wg1Re+NH1WYMcJLS3/tJmn0Ty6opzoRB/oo?=
 =?us-ascii?Q?UL1MfmM8afZMlo7phPQNm4BMc2KJO1nFhmvzEGfr3J1hIF9FSHyVf/zL4A4x?=
 =?us-ascii?Q?cbfQFhi4K6iB1WfOslZv7UAoWko56qeKwtiC7afwoKoITL+GLchkElzIFnBH?=
 =?us-ascii?Q?fQK8Dy/I/BAe3lpGahN1WwY7HEMo9rj/sn1IA4vX34myp2M9F18MhfWOa32q?=
 =?us-ascii?Q?8U5bzXjzHXIts5Lf7MSZA3PkE1yZFGWsqBDzerHuaPHaiShvG4F66a/yY+/I?=
 =?us-ascii?Q?gh9PGGrlA3r+c5be7x0KoGo+T/yBCtdXx7JxCKFu9zbZJY+YkMhdNdhJFNcC?=
 =?us-ascii?Q?SpJ1s4OmkKF8IukZZfSHSuVQgi9HFrSVOnKb8i67yJ4d0TvE6aCtL9wOEtz+?=
 =?us-ascii?Q?M+0JSZsJZYvQCiQr6szqfDttTv9PS8hkcupO3xiqXNjisG241J5tzfn29pSz?=
 =?us-ascii?Q?+IByRGiCXibDCjSRPd3tr8V3j6NsyXcrFNanhMQczOySzHenhBx5/aZFVbb8?=
 =?us-ascii?Q?2OU952gO4r6MafaUOwi76xH2WfTGM4AQcOCpsgIUNHws3rsOsDGVSsxIteex?=
 =?us-ascii?Q?j8DPg1sLRkuuxEkOaZocemvtzkIHvDiU33qEGpPxQbbCPAZdhr+rSGzmPsok?=
 =?us-ascii?Q?erPKPiCUShFPnMfL+NZoZ8+W+syAtqy9Earwzy+dHXA+z7iI2QDAmolYd+/h?=
 =?us-ascii?Q?IhTD9bhbCzPygyeErVuXDZtdpqp0vNtdmCKlNTadrP6wC8puRd44P0kl2mYN?=
 =?us-ascii?Q?59U1K27ripMTE3j8ya/m1U2KPRw0e8nJDXqjogpz+5Zrk/HJtlGSFog0uytx?=
 =?us-ascii?Q?KcPPctQsHzalCKYJlWCjbMtFXg8pqSKZRZ1oJ89tvozrVa7MwZ4qckweN5Df?=
 =?us-ascii?Q?p4i9GYC2ezuYN6KIcUq36hTmLbiJ3n8RxqrvsbcZGNESBxqc1yO940roDRI1?=
 =?us-ascii?Q?VXKEj3YXmpWb1bv/NDW+786hC/HUYdIe2kZqpCRiEQjbI5vU3D+vd7plBlgC?=
 =?us-ascii?Q?wlKqPteoZ1SNPLNd5vpWc0mGb/ONMU5yLGHT404kj53QL+fiU8C4+xTe9tD1?=
 =?us-ascii?Q?zS8NoRKZq6S9c4kBm3L5kCxicmxaw2a80zMqEU825PApnENkq245q4d2G8cm?=
 =?us-ascii?Q?ozjg0CULBC5WRvivqMxNF/CfocViV1fmBeJ/MMNDR/216YIc5qsLzcyvRs5v?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jb04EmQuxcFU9ZOlnKOAliCdGP8+OycmRzHc2NIm/62rWg2VhDor3BRHf8EWoT+jYf885HvAyr2rw9thcqwS/K6YWWuMVLJRvUflnB6m8QqEPVdLWNfo7uLGXoPLyNFLl3rXOkuHOn4bJQaXspbfLn4ZC+6DH60ZblOfVLkG00+nMa+IZESe1aGiamh3nhw+tAshrsN/234fewRmBRYU7EDGWDE83+pw4xstZJhtG5IQEq4sKtBNwTVYGWZfUK1fiDqr2Af+S8Vx9Lzwqt1BOJ6Xn+buqbuZ9cQ+3s+m/qYCRex07Acg1B7Lsz/jeYlYrxH6aLKRorm+s9JHVl2SaHOXOgD+YxodhueeSMA8o0hsbe41NjFhKHQHD6qBe36HoPhrYbNAuN65exWScjgjgLWN0U3NUlmYnVHZ2RtZe27fJyrsF3fspIIxisfBbBDAMUeSWLkfFnsw60lU7CypThinjpWzUj3xdxDMoa1ePUpPrMsp7UQnqRZ3zF8lI6mWGDBSoXzYvW8icH2bqfNbyumvhwsB26urQeVSUW9V8YONTyd1n8jJ5dPZMG6T4Bnn4V/AphQ7Y/kbYRWJTQAZb5w4XDSTVRiEGPcumwXlLko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ca3715-97b0-4d5c-f2a4-08ddada56840
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 13:46:48.7627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FEWkCYY3jw5aTe6Cq+srSjf00VpQSKff+u/AOY1XMXwfSCUgaab0iQrDVOGdohiop1Qu7sy1YbR4O1S0SMa/WBkTTL67m3dg/2PxLS71WVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=913 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDEwNyBTYWx0ZWRfX+sKfcSIM6S9t OD2FcSYws3z09lOu+KyGohs8i4Atl+XToFIQVsGgzExELGmqKYnpuzFJFqVDS1FaRMLnVRg39NI azGHj2sTh6VdIufQifI18X//prd4aV6Gmi7FfsS88lEuWrB+wteQHsUmQEJK/muFS5/6w0JMItv
 NdRoaqJ0afqvZF2zwkzdF1zQFGkvO1oiAy3N6hErUwJCIjS3JgIW25hlfxv41rJRBkzcKKkG9lT QwRO4ID68cY3THUF3IzxgY6NX97UBE5Wu8Vx2cW7L/W8N3fMWgfH/HYTkCBaZomI0mJG8BX+/l9 OgLK6mHrZXFpuJ/uBR5LjPHXL1HiFn6/TnGkWNL4vJvXEPmKM/y+mgSG3Xs35W4eUcIt2Y5f805
 XmPqGcHuXNgODciB57zT85QnJGfECSNBtHyGKwE/48du/D2moen5+4kX1VYb/ToE8wZg8a8b
X-Proofpoint-GUID: T0agSRvpUao9uUhbp5y0SUyC9hRhUf6g
X-Proofpoint-ORIG-GUID: T0agSRvpUao9uUhbp5y0SUyC9hRhUf6g
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=685171d0 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=V9ySHPybjZri8SzVnVcA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207

On Tue, Jun 17, 2025 at 09:45:32AM -0400, Jeff Layton wrote:
> On Mon, 2025-06-16 at 21:41 +0100, Al Viro wrote:
> > On Mon, Jun 16, 2025 at 08:33:19PM +0100, Lorenzo Stoakes wrote:
> > > REVIEWER'S NOTES
> > > ================
> > >
> > > I am basing this on the mm-new branch in Andrew's tree, so let me know if I
> > > should rebase anything here. Given the mm bits touched I did think perhaps
> > > we should take it through the mm tree, however it may be more sensible to
> > > take it through an fs tree - let me know!
> > >
> > > Apologies for the noise/churn, but there are some prerequisite steps here
> > > that inform an ordering - "fs: consistently use file_has_valid_mmap_hooks()
> > > helper" being especially critical, and so I put the bulk of the work in the
> > > same series.
> > >
> > > Let me know if there's anything I can do to make life easier here.
> >
> > Documentation/filesystems/porting.rst?
>
> Also, an entry for ->mmap_prepare in Documentation/filesystems/vfs.rst
> would be good.
>
> I went there first to understand what the requirements of mmap_prepare
> are, but there is nothing.

Ack, on it.

> --
> Jeff Layton <jlayton@kernel.org>
>

