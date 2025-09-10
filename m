Return-Path: <linux-fsdevel+bounces-60850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA7B52237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB0A583239
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C437E30C371;
	Wed, 10 Sep 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P2KhwpxX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ya8GU3R+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3D305940;
	Wed, 10 Sep 2025 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535850; cv=fail; b=qDpcPnpLzg5AKiWEw3UA3erJaes+KPhuq8cMiVQdLkco7Ru60ymLSNktvEiL/eishPpeG9LYJo2ixIXUpRDGH+ezOzbmmpsdtQ7GrZ2Q2Y+NW3od/fzYMBldbmvtlvyEXD9s+xNg2tqOj35R/B97o48DDyuYPQjAvY/nrW5USn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535850; c=relaxed/simple;
	bh=4zwKU3+yhg7sQh2kxmxCigZCuOarWFFxucVN++Rndfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKf7uwNt6EavlphKV5JW32Wvci7nfVT9ag/VbJ1vB3q2vp1gUYFhcEWCE+ukR7JxxpGKsbDAQWsQ/eHKp5yZejdHv/g3UxWTNChtbcJacd2p0upQqWXKqZSFd8QFyAwb0k7PX2S4i77puOyWWIa766bFAY5yNKuRixlPDI6g2to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P2KhwpxX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ya8GU3R+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfiGo009739;
	Wed, 10 Sep 2025 20:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qV/bTAUMy7Xh1fGu3pvqaeng4rc/lJ0fDkag4Iwsyl0=; b=
	P2KhwpxXxNfHXe9v9VHDaJXA/5j0Wizm86bZV3NYFBOT6IPtZU3lBpUw1K2fQGDT
	nn27tUtV4pIozhnSCcSnpXc/nEWApoO8jILVioQua6VrCjEHzTrttsIp9EhERYsB
	R+SjKQ2Q1WQtPRWngltzu4TA3xE/hjG4B/uDg6q+pd+EPLdoig3rkjCc+GZuL7MO
	9djULfhgxf6gk6P/kNuNfQyYT4ptfeXaWxOa+GAnnlt7aCwAScmjeGFm+TAg/0vg
	qZzquA4Eqxv01nR1ouq1TSAIxQbKFumBAC52v40rsj7jL1a4lyxNL07ASmj8J2/n
	jBIj/9aZGu2eJp0bEBVx4Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shvv3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AIW1Jo002913;
	Wed, 10 Sep 2025 20:23:30 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdj1ca0-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HOoUu68ejSvoQZ1KKvIGZmnrsI1HV3AoPN0So0yTsCzULA6ZiKZsYfCJHJtklxrHYN9ZtA6OS51t2phntRPXHQHd0FJ8J2WXX9Zf/VdqF9bwWbM8yT2BCkesRuhYRtI0RUy5xPUcW/XYxwGrpVfoMO8sCRyxg8AtwoDneS0xf1kPPHuYz4kIinYxODQ+TInvTF5almRImCR/UBTFlLOaLCzkjkZ8ja2XeFe54Hi8AhieVCzIMwPUi4kxSp4gBPObtIJNB5JISOBqG8zJVQm7LZC6Qgl1FaPYrCkF4I1TKMmi4TUqDg2jGGQRSRiaQNXXnbP/f8ZMMPYhnM7bD6RugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qV/bTAUMy7Xh1fGu3pvqaeng4rc/lJ0fDkag4Iwsyl0=;
 b=ygFnaHpDZNbVF20n73kMVX1bdIlArdsfYqSl3YPp5MLJVGyEcZMLWrVbpxHsQq0OZNymDwXMJqTQYOLgwKZhfJQ9yhFjvutNy4AMSYplV0oX3uDw8zvkbwA1O+kr/85F5eWknZtnFssYh9h+W2y5c0haKVWLL4GgXE0biSLcUYIlK9M0yPji8DxgriI25zF4YdZZEqOISJhQO3OAHMzJ5Ho4sUGPE2XPou6YbyS+QqwmJHoRbHN37d6oc0FNKrS/577bCvhQTMnY8swA89LXS7zIltKFZVHjFI++MUTbCcxvaqzE+jVTBuvwwMySgaY5c8UwBOO0QSDvLXrMRTjrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qV/bTAUMy7Xh1fGu3pvqaeng4rc/lJ0fDkag4Iwsyl0=;
 b=Ya8GU3R+xMhy7QQKwos9tQQz0TwWZXUXF9jFvwoLedlQS+FhBoVWPyuPLUldSCds7PW2teP8rc5R/OORHJ3trorsYUVS8o3N2Ue+lkwzxDRSIXb+d2IcciyXg2zws45eCESY2k6EfhxJMoazabp72KgZnaGIN1nWEAxLeGM1pFk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 20:23:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:23:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 15/16] fs/proc: update vmcore to use .proc_mmap_prepare
Date: Wed, 10 Sep 2025 21:22:10 +0100
Message-ID: <163fba3d7ec775ec3eb9a13bd641d3255e8ec96c.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AFB.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30d) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d5729d-eeab-4905-967d-08ddf0a7dc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yU6noUR3JLos5jQEC8qKZ24tJXNlTFMBrXqltHEcNBVctuvn9m+RRB1VqI+D?=
 =?us-ascii?Q?zv+rPjgMS16ZNTpc6X273uFAKDRBokeBr77Kolcls7djT1jSTCqYu+NLxTZo?=
 =?us-ascii?Q?NqtnH0Akv45+PUejBTTXaVVj7t6WKAk5jlQlbeJ5Co4pXKcKYzgd6rBLb6Vj?=
 =?us-ascii?Q?P+SXvcxehysB2yufhYtJWlKQT4qOoO6zszk3HkiX/XlT7cxWT8Y/7ep32DF+?=
 =?us-ascii?Q?DAHeKKppAcTp8MsVhIhLEGYaSzfkiOKImVTRQoWqf+ps+BtZIcjFmdHAGrsr?=
 =?us-ascii?Q?F6L5M+gt061aeHQG3toAH0VRkN3EUrD5CEapDfH/NP9Wi2nf83TcrtoZWAs0?=
 =?us-ascii?Q?HdEtI4brvH7LKblWerdi9eBjNtuWj3Y1q/m9BY+TPlF4PittSy7V9YjLpe4y?=
 =?us-ascii?Q?2A2HhxRNS3JX3mI/SPVyP9jDmwA65CUy6bgnOVsljIa/E5dPwsDS7vm1ssmH?=
 =?us-ascii?Q?qPR8DKo1tDiRGwG6I3Yb6eQpS6juiQEohsiryYJ3mV8VuaPWfyeVrzscWU9X?=
 =?us-ascii?Q?FXuiZMbq7ziX7n7512eOI9hGrmdfBztpRfeDljXaGCdBoQsUMB4Khykh6GvW?=
 =?us-ascii?Q?eTSYVcJYDyUCIG1HCcdEAvKQHx+9N5QEQ29AeGZ/Xc+iQpgrK6JORViStXTZ?=
 =?us-ascii?Q?TiUctcEwdcZeTeEZfckA4M/F3/fIQeOqzrM5bOoYaaMsjC/M7QttdMcHh7c/?=
 =?us-ascii?Q?xQvVVoJrZ22Zat3z/UU1R+C8qqEWUgpaH8NArltBp1bp62IkmqmNQXcNPfI1?=
 =?us-ascii?Q?ibG8W5498BRV+VNQIOfMXNcc0PJ3fGXkY4GEiL5cHgXhdxzda8Hl6vZxpVyw?=
 =?us-ascii?Q?K2eM5EY/3hBIJwRFVr0OcJGAJ2QdoCYxF0J3oabiLfpXXvslQnLdo8w/qkQB?=
 =?us-ascii?Q?ncqOB8RzPctspEqSoWHZ9y95PNx6J1WthS2gfmLE7PqysjCvjs/stpuS0qMW?=
 =?us-ascii?Q?4bWlZR7Aose/BLz4tj9ZIlllv9q0lobJb+tKAbcDHvDvPl7VTZIl2sz4oyD2?=
 =?us-ascii?Q?bHOqFUih8jEjpQ4vF37snn6LD8NLjOlzRVgtL6xy/ofIVNXZielS5AcqrIpx?=
 =?us-ascii?Q?ZcyR4ysLzJ5I+SHUmPKdgcmHEMFBwZyaxNGgDB3wyM9CqWAdrIC1QQhNiMfd?=
 =?us-ascii?Q?OiLS20mMgeuVIur46f/wTkNuAtt5ma2oUC0BW5e3/Qm9tfOae5kdkhXdfjw8?=
 =?us-ascii?Q?ikdRxFa3t8hME/dRZokFtkhl3Sywrv3Gg2DQiChgX1z0CQmC2uNG0IuDHI04?=
 =?us-ascii?Q?jBD5c77BLnFqRCphgpdm85rqw0qDgsG22zY4MWvwbJRFapDImho3O6IeGv4c?=
 =?us-ascii?Q?gKKomjZc3zdlHzFU/cJP7Bd+2JaWjodi376wEc3W/gkcne6babeqiimhkWgT?=
 =?us-ascii?Q?KjdXY3j2RjUsg6UhXs+lnZvciZrACG+kZYfvCgdoIUQmLDYZqAMFm+aBwz2h?=
 =?us-ascii?Q?gzcXc095hcw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gf1XrYMzX6PsyUI/CMKFjG2NC05e4xmI4BYhIK4tQccI5+Jpa/5/cg6ZhOxi?=
 =?us-ascii?Q?/EtIbY6JvTbwC7mKewiX11YENDdHGR0j6/KdclD0DafSTvDW5YznhqApUdLL?=
 =?us-ascii?Q?FGyeN6h93CEIJeQ7imPxuo1lPAvOQzIVuiC3Cw0xLd4+EMgPYH1DQWYR5lp7?=
 =?us-ascii?Q?OeUkr7VpgJ7huZIYamYEmbywLfUHhkRsSgJd2WqzQvxg+igRp0r1frXyAGoZ?=
 =?us-ascii?Q?DeEiJOCrp8+mk+pYbYZGyg1qBJpfDyQbbVtekVYV1EVPrn2jW+/Izeq+YtGJ?=
 =?us-ascii?Q?sa0b26KhiNpqum0VEcZgWsgfsJ6xjsUlBBWOKUxavrzZ1GrmFrqX2G+shzpe?=
 =?us-ascii?Q?SXeqQdtA+uBSWhSWNx6qGpGmOHVvK/fq/H1z135wDrXCg6rS2UrJFJ8eQVol?=
 =?us-ascii?Q?XDa7eek37gMtLm0pfCGOUWdUoAAcKvnU5vmUo2kzLCxbmN/mTc3X1RzXlSEE?=
 =?us-ascii?Q?tiBhcSANU7iqzgU4Sx5/D3YzOTlD+30i8VlAUFLsU515QTtUJOk7fWfFgb3q?=
 =?us-ascii?Q?0zkhoAkfu6DXmdE8UwLAt7H80wCTTALT4yj3LwYBV6Q6Mefj4oZu6DMxdbj/?=
 =?us-ascii?Q?DIa/fEui8We2ocfe8Kzy8jO9/eexmiUvKf8mbsFd1Vxw8boIDrPu3+3Upu/d?=
 =?us-ascii?Q?GNiCvakxciGlQqttN5ls62wqNqsAwtMt33K6p7e5S21cSv+fGNx2W7KziHe0?=
 =?us-ascii?Q?s6QXGyVwdaBBN/psygXqyLORO2CJCz1ZCHu9ay14h9puIfyUYJtLeOuCrOGx?=
 =?us-ascii?Q?TDCejJ5HpU2frHtcCoLrxsgIHDOCC70AFuErMHrU5LKwJlNxq0TiXkQmPF8C?=
 =?us-ascii?Q?vzyIfakCbpDZ/Wn+AlLTnEtVCoPTwfKEFBOCwqdIZPAZrDS045F9yd2SKC7z?=
 =?us-ascii?Q?IUdpfJxNadQKA6KzsXtXVfnfhAMNhUj9T+0zMFldQvTu6ARxSipHy+2s3GDM?=
 =?us-ascii?Q?HDTi/AgX0STav9/g0eShJHxGqNSCB/HTjzxitMo0qg0BCOvJov6JNTqEWNr0?=
 =?us-ascii?Q?3dUKTaVh8DKbnI3+O2xvfvS25fCtBt/gqloPwoqHNCRY9p5Fo0ThKk/OF+wT?=
 =?us-ascii?Q?RPDcBZsWBMmYqNMYOPz8u/6KsmMHIXhIyJuUP7vlFux3PrUw8sJZNEqzzv+w?=
 =?us-ascii?Q?DQeXfyqfFvQIPNfAUwEP4EooJC+WkijObSYkoXvsBFnPkslC82P1gPgq4fnl?=
 =?us-ascii?Q?xMpjniqru40fFt6EV0ZCLhZI/Qzfa60Z5Mdu0XGnRBvDpkupklz/duCi3sxA?=
 =?us-ascii?Q?l4kKj6IyxltzxDwTSW8zruk23xJz7o6ocMgdZ+4ciFll4V4OMEzQR00Y52xJ?=
 =?us-ascii?Q?UiGCYQXvMWdisR/6x2YYQ4ai1JDNT2fkl0CnlMeufKO4GmRq0K6Sq+KNQbLj?=
 =?us-ascii?Q?vsN6Lm/SfONrKSIvphPgCGmYzC7CYmv2/qPXuwPB49SGWDSlb2Om3ZUAhdzv?=
 =?us-ascii?Q?ZLgSzLiJoeoaBKmDHfpWIIJrGf4NBcAueNPJEK+Vunx4E1YTFWJ2BQKw0SxT?=
 =?us-ascii?Q?mvtc4n6/eftP7/UYSqXryCkHjf6Ylqwwt06mUAR0V2WJ0GXmGxOzPCbhUjQ7?=
 =?us-ascii?Q?2FI2SrGUD/K4iXwKfWVcERAVJipRfG8mWfdQ3QDOuW91yOi10IKr5fEmGrzi?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZePe0sN0X1InCwDi2llgDNBXdUc+cUaLmzq72Ig9M0fNDD2vZ3VQQgUkrpUFdWDT5WyGwzjmuNtSfHa4jGevas0eZkW10TKQUdxLcxP9aK5sSpg00gVMGI4RYejtdvEjVfdciBhs+hDBJvsYAxuljs+ydxE/gPs31RwqGcNlQ1vUYoGuQO653KMv02OHl0hf9UWpbMOBxqnLPeQn2GIAPQpd4e2//JS9JfD3F5/QgyY8X5jVv7cSVOhDBTsZcoGIevYc0xRnQhS2tLuXo7L/mDJ0rGEnJfyGBYLZpJS3Yn8mly4Tt23JLAh0ixwb6kZpXu++ZbHEXWMS0HJALt+6qkPioWV4KVffFs8Wy5sUWvI7JfVmxnpt8B6NzmGi98YAJ22QHspJfjr5w6l7p9zUkJoByFQI+laQNS2BXBRi0I+RjdC4o2oLVCh4FF4mmjnvu5sNK/GAiodbmW6lgym1wK7ELrRLyonlO1q3gwPSSKDPxQiptG4eGdVVh6ZBGeE445uSe4HjB3DEZJHwN9cc6qZggjrihperGTi8XdmTRmtIJxoOMnS6povlgvTZZmwpuK2qJmtionNbk/EILV9I4cPCAKNMaL52+BDMcyzIW8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d5729d-eeab-4905-967d-08ddf0a7dc96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:23:10.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcI4jTQMhHmAlVhvI1FV5agqCxnUpOLi1t8qoVSXOjoVHiUya39OgsbWdBbgPvkKMhYq09zgIvuPzYLMeG2nxVtRCHrgegJU101Q7OIc1FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100190
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c1de42 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=FKJ8-FkX7txb-S-0vFMA:9 cc=ntf
 awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfXwkBJiO3WUtzK
 QiRB8ol+4+EqjFst76eNQSWyqZ2olNKH31EmImYMQ3wF6KJqW98A3PR3R9HzDUG0T6LVxKwD/Gb
 G9s2az17tOw1sK6mfAwp/QTCTAsyy8CBzNGKIa5M6OCPi9HruzYI4drz68BpfpuKfa8vzjQN3YN
 wh4c5IkTfku+mc84/TMbGHWaRswtYT85doEZmhLx/n9G8REVOVlYNdbvoYKcLIPN02fPX15976C
 MF1D0MkeaO0BQ19VBi3ovZtC6namG802ISGNW1BpUE44qpwHHXujD8WoKQy/y8yRV/RxQ182Emc
 EsRg3/7u24Teg9DCA2fPNtpy5fUU8L+9QXbdaKIvL4qEun2ONsxrNcwbOEW170M1NWtLG/+7KL2
 uqh1OvvGAI0u/bK4BqE5yylCa2jj4A==
X-Proofpoint-GUID: vwcnyTtryQLKrkGlaQv-ReqeT9Ie2sDC
X-Proofpoint-ORIG-GUID: vwcnyTtryQLKrkGlaQv-ReqeT9Ie2sDC

Now we have the ability to specify a custom hook we can handle even very
customised behaviour.

As part of this change, we must also update remap_vmalloc_range_partial()
to optionally not update VMA flags. Other than then remap_vmalloc_range()
wrapper, vmcore is the only user of this function so we can simply go ahead
and add a parameter.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/kernel/crash_dump.c |  6 ++--
 fs/proc/vmcore.c              | 54 +++++++++++++++++++++++------------
 include/linux/vmalloc.h       | 10 +++----
 mm/vmalloc.c                  | 16 +++++++++--
 4 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index d4839de8ce9d..44d7902f7e41 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -186,7 +186,7 @@ static int remap_oldmem_pfn_range_kdump(struct vm_area_struct *vma,
 
 	if (pfn < oldmem_data.size >> PAGE_SHIFT) {
 		size_old = min(size, oldmem_data.size - (pfn << PAGE_SHIFT));
-		rc = remap_pfn_range(vma, from,
+		rc = remap_pfn_range_complete(vma, from,
 				     pfn + (oldmem_data.start >> PAGE_SHIFT),
 				     size_old, prot);
 		if (rc || size == size_old)
@@ -195,7 +195,7 @@ static int remap_oldmem_pfn_range_kdump(struct vm_area_struct *vma,
 		from += size_old;
 		pfn += size_old >> PAGE_SHIFT;
 	}
-	return remap_pfn_range(vma, from, pfn, size, prot);
+	return remap_pfn_range_complete(vma, from, pfn, size, prot);
 }
 
 /*
@@ -220,7 +220,7 @@ static int remap_oldmem_pfn_range_zfcpdump(struct vm_area_struct *vma,
 		from += size_hsa;
 		pfn += size_hsa >> PAGE_SHIFT;
 	}
-	return remap_pfn_range(vma, from, pfn, size, prot);
+	return remap_pfn_range_complete(vma, from, pfn, size, prot);
 }
 
 /*
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f188bd900eb2..faf811ed9b15 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -254,7 +254,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long size, pgprot_t prot)
 {
 	prot = pgprot_encrypted(prot);
-	return remap_pfn_range(vma, from, pfn, size, prot);
+	return remap_pfn_range_complete(vma, from, pfn, size, prot);
 }
 
 /*
@@ -308,7 +308,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
 			if (remap_vmalloc_range_partial(vma, dst, buf, 0,
-							tsz))
+							tsz, /* set_vma= */false))
 				return -EFAULT;
 
 			size -= tsz;
@@ -588,24 +588,15 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 	return ret;
 }
 
-static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+static int mmap_prepare_action_vmcore(struct vm_area_struct *vma)
 {
+	struct mmap_action action;
 	size_t size = vma->vm_end - vma->vm_start;
 	u64 start, end, len, tsz;
 	struct vmcore_range *m;
 
 	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
 	end = start + size;
-
-	if (size > vmcore_size || end > vmcore_size)
-		return -EINVAL;
-
-	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
-		return -EPERM;
-
-	vm_flags_mod(vma, VM_MIXEDMAP, VM_MAYWRITE | VM_MAYEXEC);
-	vma->vm_ops = &vmcore_mmap_ops;
-
 	len = 0;
 
 	if (start < elfcorebuf_sz) {
@@ -613,8 +604,10 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 
 		tsz = min(elfcorebuf_sz - (size_t)start, size);
 		pfn = __pa(elfcorebuf + start) >> PAGE_SHIFT;
-		if (remap_pfn_range(vma, vma->vm_start, pfn, tsz,
-				    vma->vm_page_prot))
+
+		mmap_action_remap(&action, vma->vm_start, pfn, tsz,
+				  vma->vm_page_prot);
+		if (mmap_action_complete(&action, vma))
 			return -EAGAIN;
 		size -= tsz;
 		start += tsz;
@@ -664,7 +657,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)start, size);
 		kaddr = elfnotes_buf + start - elfcorebuf_sz - vmcoredd_orig_sz;
 		if (remap_vmalloc_range_partial(vma, vma->vm_start + len,
-						kaddr, 0, tsz))
+				kaddr, 0, tsz, /* set_vma =*/false))
 			goto fail;
 
 		size -= tsz;
@@ -700,8 +693,33 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 	do_munmap(vma->vm_mm, vma->vm_start, len, NULL);
 	return -EAGAIN;
 }
+
+static int mmap_prepare_vmcore(struct vm_area_desc *desc)
+{
+	size_t size = vma_desc_size(desc);
+	u64 start, end;
+
+	start = (u64)desc->pgoff << PAGE_SHIFT;
+	end = start + size;
+
+	if (size > vmcore_size || end > vmcore_size)
+		return -EINVAL;
+
+	if (desc->vm_flags & (VM_WRITE | VM_EXEC))
+		return -EPERM;
+
+	/* This is a unique case where we set both PFN map and mixed map flags. */
+	desc->vm_flags |= VM_MIXEDMAP | VM_REMAP_FLAGS;
+	desc->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
+	desc->vm_ops = &vmcore_mmap_ops;
+
+	desc->action.type = MMAP_CUSTOM_ACTION;
+	desc->action.custom.action_hook = mmap_prepare_action_vmcore;
+
+	return 0;
+}
 #else
-static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+static int mmap_prepare_vmcore(struct vm_area_desc *desc)
 {
 	return -ENOSYS;
 }
@@ -712,7 +730,7 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_release	= release_vmcore,
 	.proc_read_iter	= read_vmcore,
 	.proc_lseek	= default_llseek,
-	.proc_mmap	= mmap_vmcore,
+	.proc_mmap_prepare = mmap_prepare_vmcore,
 };
 
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index eb54b7b3202f..588810e571aa 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -215,12 +215,12 @@ extern void *vmap(struct page **pages, unsigned int count,
 void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);
 extern void vunmap(const void *addr);
 
-extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
-				       unsigned long uaddr, void *kaddr,
-				       unsigned long pgoff, unsigned long size);
+int remap_vmalloc_range_partial(struct vm_area_struct *vma,
+		unsigned long uaddr, void *kaddr, unsigned long pgoff,
+		unsigned long size, bool set_vma);
 
-extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
-							unsigned long pgoff);
+int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
+		unsigned long pgoff);
 
 int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
 		     struct page **pages, unsigned int page_shift);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9fc86ddf1711..3dd9d5c441d8 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4531,6 +4531,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
  * @kaddr:		virtual address of vmalloc kernel memory
  * @pgoff:		offset from @kaddr to start at
  * @size:		size of map area
+ * @set_vma:		If true, update VMA flags
  *
  * Returns:	0 for success, -Exxx on failure
  *
@@ -4543,7 +4544,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
  */
 int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 				void *kaddr, unsigned long pgoff,
-				unsigned long size)
+				unsigned long size, bool set_vma)
 {
 	struct vm_struct *area;
 	unsigned long off;
@@ -4569,6 +4570,10 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 		return -EINVAL;
 	kaddr += off;
 
+	/* If we shouldn't modify VMA flags, vm_insert_page() mustn't. */
+	if (!set_vma && !(vma->vm_flags & VM_MIXEDMAP))
+		return -EINVAL;
+
 	do {
 		struct page *page = vmalloc_to_page(kaddr);
 		int ret;
@@ -4582,7 +4587,11 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 		size -= PAGE_SIZE;
 	} while (size > 0);
 
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+	if (set_vma)
+		vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+	else
+		VM_WARN_ON_ONCE((vma->vm_flags & (VM_DONTEXPAND | VM_DONTDUMP)) !=
+				(VM_DONTEXPAND | VM_DONTDUMP));
 
 	return 0;
 }
@@ -4606,7 +4615,8 @@ int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 {
 	return remap_vmalloc_range_partial(vma, vma->vm_start,
 					   addr, pgoff,
-					   vma->vm_end - vma->vm_start);
+					   vma->vm_end - vma->vm_start,
+					   /* set_vma= */ true);
 }
 EXPORT_SYMBOL(remap_vmalloc_range);
 
-- 
2.51.0


