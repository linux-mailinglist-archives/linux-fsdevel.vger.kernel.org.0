Return-Path: <linux-fsdevel+bounces-73239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E913ED1338F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A0C5301BB11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC932DE6F4;
	Mon, 12 Jan 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iTGwbz9t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wAo/Sdp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EED266581;
	Mon, 12 Jan 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228431; cv=fail; b=mw4625crPRE9EaAnIOdEF5urBxi2t1soWhX4b6C6oslThTCNt7tKIQIkyHXSNUP/zG7HM/OnAuNp7TPFawGsvZAORrwqcHhqwv4NfC0T5CMuXtE0aHpHfudj1w1JumX78FeMRGt1Al/wk4TdcPFwDXnd/JtLmhmzDKSgodc21yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228431; c=relaxed/simple;
	bh=khaKLuG4m6BDFUB5qMWkGNggLX0LWqh1Xw9fRpuFVfU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RRj/n2FefZgDwAaAHt7MJls/oCO1z92/XKJzvgWuB1RxllI9s8e3MB5aOmOtsx7AImI5yhtjsSn7AC5BRQOWMhNdLbn11N/KJ/T1Xk71P/qvHmZXYfVwUBnEcOcxAEl9ftoxQDbvNqXbCpMnT7g+a7vKlBu7O7ljixb4WOAt1SU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iTGwbz9t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wAo/Sdp0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C1TSnC349085;
	Mon, 12 Jan 2026 14:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7V9GkzD1iCuBUHOWM7OOblIVrJ4wtqKxzANd0Czv6KA=; b=
	iTGwbz9t9GdoPido+lA9LHr35U5vQStJsB35KPGIyPfcBF5eIpMttHl7eVlJjHdO
	iIXIAMpahJVx4RakGYU2hoXJ8UtKCdWwK7q+a9hFTRSCM3jMa6yJECp27s59Wnd4
	CSsM4RBH2MrWuAJAm5hsUYCKm4Dv54gn/xt6w/oQ62+XqMmbW4FLZBLKZvYZ0mTJ
	lbgKpMw7I5poxB0SHD9Ttb+PA95qr+cJO46joGLsvj5TKCTbiDkeYoFCGX+Cf2Nq
	xBPkQ+VoArALEITZ5N/l+1Aos4VhqXqGDKMjr3KVw6oKBtIzKfHpvESdfr0CZSS/
	R3ismZgAzDSfUKtW2b7Cfw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrr89pkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 14:32:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60CE470M004234;
	Mon, 12 Jan 2026 14:32:15 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010013.outbound.protection.outlook.com [40.93.198.13])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7h8pfb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Jan 2026 14:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIDbXqgBU8C8I4heZsIjZ5/gy3Pob3/Bwp6dQosuW6aCP9toMf6Aw92fkN6CrY43Np57QVOEF8zA/L/1t2MgMAheBdNFK6mGYfppsVYtCA5imvwYgIXi4JxoNg1bbkb7VFNQK7CaItOoltpnHJikG7p8TRMlYxQUyhQFDFmRZaXaKs0cdQNKoWQzth0bUKIF4stXt44rhwW4vLgXDi2jhDU5aVXxDEIGxXHrX31T2j7H0Crhry9+aVxCePAsnP0VjT8F04gEAlOj9gRbYQTKIFD84ja5JZMG45hwKg//4hTMdjBZCrR5etS0QJsRwm3ZgW/pTsY8hd5jpBlfHBIRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V9GkzD1iCuBUHOWM7OOblIVrJ4wtqKxzANd0Czv6KA=;
 b=nVGSGU/cpQcc/uFJs3dmDPokX1tvyCxcUMf8ysmmNfo7MeLL0C1epKq1cxRuLaXGlxbcN6bWrfEqmOo2lafD6fVnDC1PnGNO7kWf+UTT+EAVnk6BMPvA9M0bR5NCJg5rtuioM6Z9BuYNz2sO+VqtKUigIq2dyOtA1LjHFe0cc5D3aRnpJiollPL3NwocPVy8vJcy9P0sCIFJZNDObuXAad6XIgozLtQyYSKPpigxtAk0e7NgbGHOi8i04180xvqUPCoN2CdmlOtaXuTcSaAl3RIxsnfCg6ZXQkZ0V8K+DUVHb8RdfHoWoLTnL9m4GQyTssxVxUKET2zzDbc2qBWDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V9GkzD1iCuBUHOWM7OOblIVrJ4wtqKxzANd0Czv6KA=;
 b=wAo/Sdp0wCpBO8TrV5kuZhkPnUqHNAgl9hBiGheXHQsoX3eNOKIL91P/nTWPvZQe2ITszNOj8Bq0xnAC4Ws3aRJGrp4Fkl8E5nFLKs7EdZ3udBFzBe9cJ57/ZljYDbWUhwlmlKrUq77u+hUJIe88L9NTBYNfjZL7mpRdxFn3gYA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5969.namprd10.prod.outlook.com (2603:10b6:208:3ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 14:32:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:32:10 +0000
Message-ID: <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
Date: Mon, 12 Jan 2026 09:31:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Christoph Hellwig <hch@infradead.org>, Anders Larsen <al@alarsen.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale
 <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mike Marshall
 <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Phillip Lougher
 <phillip@squashfs.org.uk>,
        Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <yuezhang.mo@sony.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov
 <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Xiubo Li
 <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
        Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org,
        v9fs@lists.linux.dev, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
 <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:610:4e::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 583a59bd-b7f9-4d41-a0e2-08de51e75e7f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3122999015|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WVRyUU5zL21VZEhHNnU5UHNsdUdjRU1LTWYyM0c0UGEzb1E5U2lja3dNVlkz?=
 =?utf-8?B?djE4bVJPZjB2aFpyZW1GY2pHZHkvYmdoSmxNeG95ZXpyTlhSMi9jZnhwV21D?=
 =?utf-8?B?cjlxUWQ4SGhaOVp3d0J5RXJXYmtFenMwMjhzNnFjSkx1RnlBazZ2QTJ6c2Vq?=
 =?utf-8?B?VmZEdUZRUXN5OVJUMnBFMDcvcU9wOXZyM29qWHdObE5kV2R5UUVzTDZKRjFw?=
 =?utf-8?B?eHBGS3pTbWpwRVR5YTNNd1ZVMmdvT20ya3p6M1dZS2JUelRzMEJLVGlVMG9Y?=
 =?utf-8?B?TEt5UTRlS1lHUEg5a29yQ3QySnlmU3dQem5ZS3JZZmE2US9JbjBwV0UwSDR4?=
 =?utf-8?B?MzJKeVc1VE90VjNyL2NVZzgwYzJTQUU0VWdMbXVGVnBSWW9LdndPWjM4eTAz?=
 =?utf-8?B?NTJwZzNSejZOZG8vQlRyLzhjWVdsNmh4eXZvSkMvTnA4T1QzSEIxaGw5aG90?=
 =?utf-8?B?MjZXc1hsS2gxWWJlLzluZDRUMXQrd3lyK2g3R3g3ZExZZENXSjhJaFN4cTl1?=
 =?utf-8?B?czBNWkZBS2oxTjJIVEJoZ0hLZXZxL2dFZzNQaXExclI0bzIrWStZaEN3NFV5?=
 =?utf-8?B?c2U5c3lKdk5QK0x5MzhyMENrb2JnK1dIMkI0aTVvc0tPQjJoUzJJYy9pWm5X?=
 =?utf-8?B?cEM3dStYcEJTUzFrcnk4Z0E1Tnhxck5QWWVvaHBsajVYRDMxY2E4aDZhK3lE?=
 =?utf-8?B?TGIvMDFEQVVIYmVGallBcGVjOEd6Uk9WYWdXWlNKWVFxdm52MjBvV0dndmNn?=
 =?utf-8?B?NzNORkFJOGlOclB4cU9kbi85SnB6U3ZRL3JJRXZpVVJHaG5sM0VZNy95Nitz?=
 =?utf-8?B?WGdRb0R1MUVCejQ0YjQvcm5kclVjaTlXWGVUSUVhWWR5US9iQWdCakFyeTNI?=
 =?utf-8?B?QVBteDJublpTcU1zblZSUjBmRlpsNjVZd1R0UityVTRueS9tQ0w2WmZWZThy?=
 =?utf-8?B?V2U4U1hzSlV5aGNJOElHVzZjM3ovNW1lc1Z1ek5WRW5CVlNyZS8zeDN5YUIx?=
 =?utf-8?B?eEw2b0NZNmFpbS9URThXeWRNZGpDYkZGd2JpY1JWYjI0MXRqc0pOQzlFM0hu?=
 =?utf-8?B?cXVqQzVWWEpHOHoxaXQ1M3lCN1N4QTlaN0o0R2h6RWoyVE9kSFIyT3hROUVq?=
 =?utf-8?B?MkpRRUxtcE54QVRkaU85S2YrTEdGNWpRMXczUk02ZTZFb1B6VFd5NFc1OFF5?=
 =?utf-8?B?L2dOYTFDZWtPYmNCOTdWd2Z4ZXpYa1RGSnJKMGdZT2dLdlhLN3N3dU5LMWc4?=
 =?utf-8?B?ODFyWmdqOTJvL3gxTVVvVkVXanprNFZKT1lIR0Q0dzd3ampoQ3ZWWU1MdGFQ?=
 =?utf-8?B?SzFobmRya0VGeEdYNG4zaFFBNDNDbEJURTRFdjhWNmhMR2w4UkI3YXhmVTFl?=
 =?utf-8?B?dlFlMmRwcDd0MmlwUDhwcUNFT1F1YUxKRTFnMWcvWUFDWFg1VEQza2VZVEY5?=
 =?utf-8?B?NEtIZ0ZEU2tYUVYzVGROaXJwcXZvOWQxclZhNER5RlhkMVJYWjJZMW83ZXp3?=
 =?utf-8?B?amZzOFBOSXlmdUljQmh5dkxkdGQ3a0NPZjMzMmdwY3hObGw5Y3FkQkk4L1dj?=
 =?utf-8?B?U3JEWUtsa2JUdXU4Yk10NE9VWUV3MEZwcnVUblQ1RGpKcDM2ZFNlMXk1QVor?=
 =?utf-8?B?VDdGYUJiREs3Z1c3YWlGcTlvVTlTVVErNXA4OWg3T3Y4MXlvNWRVdGJTYVR3?=
 =?utf-8?B?MUxiYVRRNmhrVzNPbGdCVkdKc3R2ZlRFR0VMb0JWZ3FjUkRBcUFuR0I3NWh2?=
 =?utf-8?B?ZFZ2YjZNbTVWSG1rczhGcHhyc3JnLzQyZy9GaUlQUzgzMlhINWVyVlh6SndQ?=
 =?utf-8?B?YmVONnN4Nk1EUEdVQnNxOXJ1K3VJL1Y1RlVEMmpNSktOTWlCeTlMUW4zWlJo?=
 =?utf-8?B?V2E0RUJlckZ4TGFOS0F6RVE1S1VFd1VTVFIybC9idFptWXFQVmt0UElxTGgw?=
 =?utf-8?Q?VQDlyfwE4jXvrfLm1+OZStl+fhIOQFyV?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3122999015)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UnEveEhDQ3lKTllNMXc5VE5sZUVrSVlBZjlHbjg4RUptSnhqd1daWlphS2JX?=
 =?utf-8?B?eFpNZDhPYlNIVnBkSHpYbXBzK1hkWU0xK3A2N2lobVVhSGNZOVY1RHVTTEpw?=
 =?utf-8?B?TmtIOVhTbjNwMldnR3ArK0pHK0NQNDEzclh1ZElVVUQ5U3BhdFM0SFdWNnlp?=
 =?utf-8?B?dDZsc1c1WTFybEljTUpYK1ZUM1NFTHoyVFlpK2tPU0c1anJyNVIvY1lJOGVD?=
 =?utf-8?B?aUdKT2NmcEViSnpqQklNblJiQTU2elJ0Um1PZTF3TXBBVGwxMlIrOFlabnlD?=
 =?utf-8?B?L2QwZS9GWVhVWmhQbEZrQjQ0SDVGbkVDZFRWTExoYWVFRERhajR5V3Mza1pa?=
 =?utf-8?B?SmdqSk1PY09MdVdJWXh1YU8yOEVWcXZqdlZqNGl4dStjZWdWMTdmZlFVeGlq?=
 =?utf-8?B?ZzhjUXorbFNOMEF2U2VKNnM5VDVaaWtGMGJqUDFZTk5LUFJWWWFTdjhUTmJK?=
 =?utf-8?B?ZTZERXlBWXN0VDhHYk12VXRTZ1gxVUVjVlVxVzlibUFWTStyRzRacGd2dHJ1?=
 =?utf-8?B?ZGtRWnpRcmJLWHpqWVljUVN2Snl0VlRkSDNJNGp1cEE3U3RFN3o2enVIM2pJ?=
 =?utf-8?B?bFBYMmxkSkJUMW1NSGQxYVBqLzhudmZOTTRnMDcweHVzYmJDSTUwWmd1ZnpG?=
 =?utf-8?B?b3h1VU5rdUdtTEZ2WGNQbTF2RW9FY29EaGFhbk84UnRMV004bjFxQ1NjZndJ?=
 =?utf-8?B?aTdwZWgzNFFFMDdxMnE5ekdPcGhta2d0T01pTnVXbnp3Ym9RREdrZTg1eU5x?=
 =?utf-8?B?NUpkVlB3OE9ValorWjdWbTdSVVdCNjVybTNlaEkxODFHMEUza0cxb05jc1ZY?=
 =?utf-8?B?Rkxnam03ejZaOGIybS80YU00T1VielNkcjhBd0xaTHVqeE9yU1ZkRjFxVUkw?=
 =?utf-8?B?VHc4TGdrYTlMeExGUDZ6SjVtRjYrYUhNcE1qYlljSlFkcnUxNWV5V2tJMDRm?=
 =?utf-8?B?NzExbXdPckdZL3krbFVobkxIUUMwYnZEdE9aWUs5enkraE1hUHkwcEVzMnFl?=
 =?utf-8?B?WnE0SFgwekFoZXY4VUdYbjJTc000SkpzcXdtNTk2NVpUTWRDVnZFM3B1ZG80?=
 =?utf-8?B?bzFKZUdneW1DT0UvQ0lBMG1vVU1iZG43Z0V0Y0w5bVRxNnZQd0VZc29GZy9j?=
 =?utf-8?B?TExzYm9PVmtLbnJlT1VBR0ZNNGx3a1lRTWdqbzBibnJVZWFnVVlrdEhVNFlU?=
 =?utf-8?B?NTlJTnRBa3V1Y0J6cU1iWTNUMXpLdVBYemM0L09TbHdtTlVjZEcwOEtYblVO?=
 =?utf-8?B?TVQ1bmV1MFA0SWhTbnBsdy9obFNFYnNsZ2pqVDVWZ1FmWTUwR2loMnhCODh6?=
 =?utf-8?B?elF0V3JCaFpxTXd6Y0IxdFFFclNCSXZQSmc2WWplQk9WWEcvcjJ6akdrV3ZW?=
 =?utf-8?B?TURtK09hRjhabjVMcFFFVXoyNUkyV21FVXR2K2I4bHZVUUdjV01yVjROQ2dC?=
 =?utf-8?B?NTByQWdzZ0srOE1sWkg4d1EzNkF4eEN6TG9oN2VvUFZGMzFzVmFSTkU0TGVO?=
 =?utf-8?B?eU5VTjkzVUJmN3ltSElReXIvNHZjWW9lRE5Gdm9zK0J4cWdSdStGbFZ3MnBK?=
 =?utf-8?B?OHNyayt3WlNVVlFwdFluTGxwN2JxMzNEbGZNeFQ3SmIrYkhEUTdlK085RXFy?=
 =?utf-8?B?cldYaTcvb01HRFZtZnBpTDBleExOeWV6U1E1bk9tTnRHTDlxTVFXc0p1YjhH?=
 =?utf-8?B?NWp6eEhraEJQYkNveEo3U1owL1Bucm9oVm9TWVB4dWp0UXp5RFptZk5EbE5l?=
 =?utf-8?B?TUI4OFpWUGMvaFlHbTJhOUhNWTNtZDV2S21ZRWF4dHVHWURSaWRGZlFlT2Zj?=
 =?utf-8?B?RERXakJFM0VLRHhqZUNCSlpleDFZNlpxa1Jpck9MbXYvTktYRThpekp2WTA4?=
 =?utf-8?B?cE40RnpxTFUwcDhCdHlaWGpVQ0JlZnptTEMxS0l0WGhTU3lXY0t5dzJydjh0?=
 =?utf-8?B?Nk9KanNGSENMOTBzUzdlOXBLQzBjS09XSnptcSt5SWl4ODlRb3h4aVRTZVNX?=
 =?utf-8?B?YkM0YXNTaFlOdU1qTDhJK0lCQktmd2FFOWhUWFppdzRUM0xGMkFTUzkxY0Fi?=
 =?utf-8?B?Wm5INlVjTHJxcWtGSWxOaXpyTG11VE1nQmZZb0VWcmlkYUpuRDRsZlVyK2NR?=
 =?utf-8?B?dXFpNUJvbU5zTUR1VEp4V3QwZzJRTGJuZUgrclBNUmtaWVlLb3o4SGtDTXFN?=
 =?utf-8?B?UUdqU0JzamwwZW5yclByVU5xSTFWcWtHandBOFAvbTVpeDRpNk9NUS9oemYv?=
 =?utf-8?B?eHV6cms4MGFQbTZpZ0tZZmNWb1N0VGJ3WDBheGsxVUNxT2lRbzVGS0l1aHNa?=
 =?utf-8?B?VGRoblVyei80NG8wZ2tpb3l0Nk5sOGNVVVlRU1FTUDNFbzdwbUJFQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HJloHM0FYYfNlO2ZJLQuxsWHPIvGzM/mF7aV05sp9fkdzgVXQ9IJfqnsh3HBtZ0LLN7qKX+i6oFKAyvctl2vRNQ4gWO362ErHsbJ5BHA05KI/DHaYZ70cyrAJYFXGOEdo3PUXXBfVUVanXQYAdh7wLsK8nYkH8f40f8wtPKcxtHx1oB1qSfQPQ1SZ4LWH1wuwdFrIBSSqOpoYw6gmC3waswGJDM//UUqgape0WMZSS//Kh0nsuKxQfjlRSJKzryWTFRvbC8iDfJR9ZOPCw5WhVEhQgsyrdmbVquvk3RGvZ9AhEeO5IjCxn8QFw3pUfY4PnrFUAw6KvPrfC+nwNlN8SFXhtaeIn1/GcNJGMoISVMtnftmt0z0MYu3GERI8Yfx45RE06JPRgAGCONeI3qvN2+tgRqy+gdBKw5mzFkDyQG353SIhV4TwhITzKnwpc80YG7HmEpfq/qaZeV6w3wdHM4TWToCqaEmdxu1g+T0cHTFZe/ppoDsaQ35RjpAvlZU+cfJUaoI5VcEztBV5PHpd/I6Jr52PwK08EEyImuEIBmfqcv4f0SKxe7jDAnWkP6GUYZ+9/RzigcSQgu7vNrox2ldrOmAS6pOA7OulWVLYhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 583a59bd-b7f9-4d41-a0e2-08de51e75e7f
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 14:32:09.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: styktScrdG1r5zo59+00+FG+85xehVyuNIiEwis60h97TGtHzVHUBReKnL2RUZLT5oJYBFdxFpdUQ7BxEjYlrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601120117
X-Proofpoint-ORIG-GUID: Qs3ZsZb9yaReWr0nN9-5pzbaZCVTmoOQ
X-Proofpoint-GUID: Qs3ZsZb9yaReWr0nN9-5pzbaZCVTmoOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDExOCBTYWx0ZWRfXy8bAqLJBnu+h
 l3NnC/vUIZRmHsl6LhJlAXOirFy/PvD/yRoiXmlF9NYLw2j2KbW+z69M1EQlrdU7VmJi8ecAd3r
 qgSzxeV8nlQl+EID2Tpt92yqK2JsbCscu+Req3U1zDPRF4a1rMjZy602qIkhik+M/9cIAMZFWYl
 90TfW+t1PPNiv5rAYnJGin5IgXYvh9NhdQOyIwdSiw3VJS/2dXb5DWMmfRqcUCNNpu03TU8cIVN
 S9Ulb/L2482mlCEFgWp1lLaON9ulSW0pvEtWBcexDH25qz5SZI4kVB0bKBrtNu9hJNHnVxPm7/B
 8dCCwgNVuMYLRcrXG7Y+nCLKiIBbwWWzdnO7cO122vX+67m0SlX4PTTCPbrvdZWu5jdwUhzjhJ2
 hbXiDVVgJ4aPYto+Cdrv019PvpHz0BiTMf3Veli6q6AUU/ebI4wfKXfslLuDQoPdrKULPpjXigK
 PDhhXfNuAPzFFDMrqtQdve/hgwssHGuTWvhhZpJo=
X-Authority-Analysis: v=2.4 cv=QIllhwLL c=1 sm=1 tr=0 ts=696505f0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Sx9y5-vS8RwRFUeMaqUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12110

On 1/12/26 8:34 AM, Jeff Layton wrote:
> On Fri, 2026-01-09 at 19:52 +0100, Amir Goldstein wrote:
>> On Thu, Jan 8, 2026 at 7:57 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
>>>> On Thu 08-01-26 12:12:55, Jeff Layton wrote:
>>>>> Yesterday, I sent patches to fix how directory delegation support is
>>>>> handled on filesystems where the should be disabled [1]. That set is
>>>>> appropriate for v6.19. For v7.0, I want to make lease support be more
>>>>> opt-in, rather than opt-out:
>>>>>
>>>>> For historical reasons, when ->setlease() file_operation is set to NULL,
>>>>> the default is to use the kernel-internal lease implementation. This
>>>>> means that if you want to disable them, you need to explicitly set the
>>>>> ->setlease() file_operation to simple_nosetlease() or the equivalent.
>>>>>
>>>>> This has caused a number of problems over the years as some filesystems
>>>>> have inadvertantly allowed leases to be acquired simply by having left
>>>>> it set to NULL. It would be better if filesystems had to opt-in to lease
>>>>> support, particularly with the advent of directory delegations.
>>>>>
>>>>> This series has sets the ->setlease() operation in a pile of existing
>>>>> local filesystems to generic_setlease() and then changes
>>>>> kernel_setlease() to return -EINVAL when the setlease() operation is not
>>>>> set.
>>>>>
>>>>> With this change, new filesystems will need to explicitly set the
>>>>> ->setlease() operations in order to provide lease and delegation
>>>>> support.
>>>>>
>>>>> I mainly focused on filesystems that are NFS exportable, since NFS and
>>>>> SMB are the main users of file leases, and they tend to end up exporting
>>>>> the same filesystem types. Let me know if I've missed any.
>>>>
>>>> So, what about kernfs and fuse? They seem to be exportable and don't have
>>>> .setlease set...
>>>>
>>>
>>> Yes, FUSE needs this too. I'll add a patch for that.
>>>
>>> As far as kernfs goes: AIUI, that's basically what sysfs and resctrl
>>> are built on. Do we really expect people to set leases there?
>>>
>>> I guess it's technically a regression since you could set them on those
>>> sorts of files earlier, but people don't usually export kernfs based
>>> filesystems via NFS or SMB, and that seems like something that could be
>>> used to make mischief.
>>>
>>> AFAICT, kernfs_export_ops is mostly to support open_by_handle_at(). See
>>> commit aa8188253474 ("kernfs: add exportfs operations").
>>>
>>> One idea: we could add a wrapper around generic_setlease() for
>>> filesystems like this that will do a WARN_ONCE() and then call
>>> generic_setlease(). That would keep leases working on them but we might
>>> get some reports that would tell us who's setting leases on these files
>>> and why.
>>
>> IMO, you are being too cautious, but whatever.
>>
>> It is not accurate that kernfs filesystems are NFS exportable in general.
>> Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.
>>
>> If any application is using leases on cgroup files, it must be some
>> very advanced runtime (i.e. systemd), so we should know about the
>> regression sooner rather than later.
>>
> 
> I think so too. For now, I think I'll not bother with the WARN_ONCE().
> Let's just leave kernfs out of the set until someone presents a real
> use-case.
> 
>> There are also the recently added nsfs and pidfs export_operations.
>>
>> I have a recollection about wanting to be explicit about not allowing
>> those to be exportable to NFS (nsfs specifically), but I can't see where
>> and if that restriction was done.
>>
>> Christian? Do you remember?
>>
> 
> (cc'ing Chuck)
> 
> FWIW, you can currently export and mount /sys/fs/cgroup via NFS. The
> directory doesn't show up when you try to get to it via NFSv4, but you
> can mount it using v3 and READDIR works. The files are all empty when
> you try to read them. I didn't try to do any writes.
> 
> Should we add a mechanism to prevent exporting these sorts of
> filesystems?
> 
> Even better would be to make nfsd exporting explicitly opt-in. What if
> we were to add a EXPORT_OP_NFSD flag that explicitly allows filesystems
> to opt-in to NFS exporting, and check for that in __fh_verify()? We'd
> have to add it to a bunch of existing filesystems, but that's fairly
> simple to do with an LLM.

What's the active harm in exporting /sys/fs/cgroup ? It has to be done
explicitly via /etc/exports, so this is under the NFS server admin's
control. Is it an attack surface?


-- 
Chuck Lever

