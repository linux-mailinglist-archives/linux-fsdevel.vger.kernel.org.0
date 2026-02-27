Return-Path: <linux-fsdevel+bounces-78698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHihKc5koWnIsQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 10:33:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7081B5606
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 10:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C3CE30862EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D853D333B;
	Fri, 27 Feb 2026 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KkIQ0NNs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7738A702;
	Fri, 27 Feb 2026 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772184724; cv=fail; b=sgT4PUDWD+k2ZSCB0R6tNdoL85Jd3AaD958fGfzOydl+NUlRYXmZNE2APRQ6K/VZEclaN2v8n/pjxjQ+CLSvg+eSmwqz+LSBL/15GC2y5uA0CfKZUvK2yWWH0YlbCzbH8OKMYvcZ4T+K/zAzUklDL8JLqpjlvKJrLjz1/vpIxVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772184724; c=relaxed/simple;
	bh=JwqgT0K9m90SpEwj2lh+BM3Hefh9zmxXWVNti2arIvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OWNVGY1MDw4s6egyqwuNPSIkZJYMEhgqza9+qJAOHWc7ZfLIBtsb53aH1XjpN3Xlc9wfL3Y2UyHf8qnIEYBprj8SDpiSejBZ6ZQ0MXsdpJ4ZQidhkDOyILj+m6rE5YG6Q3GtUZGEhMDIOLPt655WCu6jUtw3Eup1YhhwLkAs3gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KkIQ0NNs; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCHSDbCvmVhmcdnKEad9Km5M9MzASu7TyWnhLDs9zZsxDd1MPicDCU/qXgA8Z9D12C6BINenyWOrYAhuMtQecMyCos+/FLxa1xAr9EY3JU5oFsCb04mp7FQRex6YmMrTpgE77qNkyJKIvYCHqzut9YxFdFt9DVH0y/uxWWXWFaohOsxjB9s0gZ9aptLlUNAxxLDQeZz+UjFFeetZ7kYlje25LyOXXT8AmEV5JSgW2lHPlEi5TCG3b1T2HML7W8HE/lJNGgDKEjJy7/NqNeA3q9ZN7k3QxZ1yKacI7mHTJbZoYkZpZcQSAItjwBHo8pI4GxC3exIrVOeOHTy7PzV/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEmRWOKcewE9O68wF5PY6k+l1fLJQ37vG0E4uqPWjpE=;
 b=nkK3nWwFFkJfEhqly6eGTbEf+5DHjcAZdeVv30dJVp0dWup6vDCBFPFCi5UB0l9JkWpcWpFSlTlpgjBrSUyWYHUlgHSnZz2hqy+s2W6Y2HybHgbJVlZwwRZwckHFry+UJoVtjnxg5P+YYcjl8tnyG4+l4/A9d6mHtffI20K7vIcrwJhsyJLw8WBTUTVroir1IdUBW04PzSNqezzgJcwZNv0cpIGoXwW9TVWD5jvkoMJ+fyAra4VqEef97ZRhLe0niyl4+hfTpHZ5pTt7BiR6lQqjnOalPkHdaD+slgL/hYDPmjvGUwQSx86nxmrmqLmBnfepPM6W9Vtm++iGpCRyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEmRWOKcewE9O68wF5PY6k+l1fLJQ37vG0E4uqPWjpE=;
 b=KkIQ0NNs/MMmHMR5Ayj3D8KW9gdGwjs6CX2302H6SjJhkidf+JOt4k6Q7CrS8UOE+emO2qzCjFskTtfniboJSJXZlWt1HNo2Uv0lrP7xic7ppcdfYmA7mK8OiRGtZ6NInKfsHoVuhgGPlJrK1JLdIwrbXvdwTJVWVLSq6v7u0LY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 09:31:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 09:31:52 +0000
Message-ID: <b4f32cab-2b34-4002-83d1-3ae038a4bb38@amd.com>
Date: Fri, 27 Feb 2026 10:30:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/61] vfs: change inode->i_ino from unsigned long to u64
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Bharath SM
 <bharathsm@microsoft.com>, Alexander Aring <alex.aring@gmail.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 David Sterba <dsterba@suse.com>, Marc Dionne <marc.dionne@auristor.com>,
 Ian Kent <raven@themaw.net>, Luis de Bethencourt <luisbg@kernel.org>,
 Salah Triki <salah.triki@gmail.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
 Nicolas Pitre <nico@fluxnic.net>, Tyler Hicks <code@tyhicks.com>,
 Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 Dave Kleikamp <shaggy@kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Mike Marshall
 <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Anders Larsen <al@alarsen.net>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Damien Le Moal <dlemoal@kernel.org>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Martin Schiller <ms@dev.tdt.de>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
 fsverity@lists.linux.dev, linux-mm@kvack.org, netfs@lists.linux.dev,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-nilfs@vger.kernel.org,
 v9fs@lists.linux.dev, linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0488.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 75791efb-22e9-4b6e-715e-08de75e309e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	SBQRiOcLfgIuBcEj7FLBvnDEPMqiq1zuqsMYQeUB/hbJYaNtACQRnKA7V1oc9e9aHsj8H4kvGGSfXqUFZ4F18XJtCYhUWGLYHO4DN7iCnwDwA4LrOxNNouGdFf9Kd3gXyxPhZAWshyckxrDqY1XBX9sEim6w3JEcm3IaOBLFYFMuWmCJ5GeAkszIgzDLE/XoagdbepDqITXFEWMzOwUTcH59vFiyMhVRK4J0oA+dY+Y4GJUo/FNM+45ZsXJbR9v7f/kpHpVllz/IFC0KNudRpbniiU4Wm23RZbtgaQmlG9s7VPHdrO/kFCpCyfpQK2Tyyi7Kc1/jlesg+jr/qanhGOg4yK9+uDuoa9f1aLT/VbII41AqjrA8GN9EsiwdPioW/91hJJqnN/Pg62YHw+bAPedUQKGroX+YqB6UnbHhDytaNH4/5msOKug/BGWyWgAbpSXdK0jmezKai7Cbh+iPOQLt0zhbEk82DhybeQl2xLMzzdc43C58HWUfFUATJodI1/N4NwLnJ/a1dsG66BM/2eFKKOOHv0i4AJM6e6qYx1Nh1HXaYz4Q+j6hRgdZaYFSfIbFiAb604wGdLQz/u7LjtlpEeqfXAbnTFyh+AxbSgvAzTFokA1wZc5ZQoZmE6c8cpda2JwiORYNgisIL3mNS5IF29tv+6fkNf1W0oU54iybNmzexNebVK0z0HAKOD64FdwVLx7MScJOXe9wge1xJZCpgKf9x5v6K7R7C+zSKZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(7142099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2dSNWRuWVVTUjNYdnRvazFaVEo1bEhYQWRZdzB5YWtVWEVMbGl1TVFoYzFN?=
 =?utf-8?B?WVdZUDlXL2VDTDBzOGo5M1d3aGJUTTFEcUZyeml0ejFUY1RnaWRSUzlkcE04?=
 =?utf-8?B?YzVmcmVIYjNYd3lNdDRUWTFCcTA5TEkydnRvVGlDcmtOSjR3enVUTWU5SWpF?=
 =?utf-8?B?ZzZiMHN2ZUNkUmxMdWFXR01HVlB0Z2FrclZ4R2h1WkRCYmZRdHVzaDcrWVVW?=
 =?utf-8?B?aU1VdkYzaUNDYkF3aTRTT2cvWlFMckE1eVF1ZWsvQUdKeWdWR1BMZGdiTkYz?=
 =?utf-8?B?NnhvVXpnc2tscnhFUUpxZG50UE9lOThsbjJreHdXZ25JUG1xWUo2SllkaW1T?=
 =?utf-8?B?VlZIUEZ0OG5oeStsdnVqaFZOVmFvL2FXU3BWeDdEeUFTcTF2RXJZdlp3S1By?=
 =?utf-8?B?VkMwUmd0UDlDVDl3ZGtFRUEweUgzWkQvVTFPN294Y3l3YnRJY09VdVZvRnlN?=
 =?utf-8?B?aXJxaE95dG9MSUlxTXRtZzl0KytOZkFVMmIyTG82amhxUEQzRit1Q2wrSjVD?=
 =?utf-8?B?TUJoNXJCYlQ3SHRqZ3ViZklJak4rK283SmZCVkJnRUpuL21zZ1ppQkI4c3NK?=
 =?utf-8?B?T2RQRUdsc0pGUW4vaHI2cTB4WDkwdVcvdXg0akxVdjV0M2R3RmxCcjlON0xR?=
 =?utf-8?B?MkZvbFRwSEZwQ2VSNUR3WnFuS1pIR0ZlQVhoUEdPektSR1hiMnpjNmRtVXBm?=
 =?utf-8?B?alNJZnRZWFFiblFXZVdOMFc5YWJsMHdMbXljSk9QemJMemIveW1kaEE0VVFQ?=
 =?utf-8?B?TE0zSHo4NWk3aitUeVhPYllFRUxRdmdSMUF4UkVWS0NYRFdwbThXbTRMczNh?=
 =?utf-8?B?Y3RKTVh3NFdUekNPdDFFU2hqU0NwSGN1QzdBK0plQlVEcFFGQVlGR2ZHcjF6?=
 =?utf-8?B?ZlFkczJZbjI1V0hEekNiTnZsdloyT1hDOFlhaVhRV0RMUE5Jb1ZCMWRSR3Nj?=
 =?utf-8?B?S2NVZVhxUThWR2JwM1JwS3VFY0tDN2FyYk51WXlTRUFHUHc3aC9MV0RyZkd1?=
 =?utf-8?B?MXE2Z3VxWmI4UWJQaUVHMUdqZWVWTXBHM2gxNk0yL2FmSlhCdXRieW1RdGpY?=
 =?utf-8?B?RytTOUZvNHJ2ZWE1SThuL2NPZy9kSk14WlIxd2Z1Y1lMQStNK010M0dYNHlk?=
 =?utf-8?B?YkdyQkRIUVhYcjcvSFdnNUtuNWJtaHQvOUF0Zm5DT0lxNEFpZnpVT1NKRGZz?=
 =?utf-8?B?bWhGU2ZPVmZSemdOclJ0cVpDNjJHVmQ3NXBXdTBHamJ6VEFKK05IMW9qRENi?=
 =?utf-8?B?cFptemJ6M1pmWHl5SHJjblhqWlN2NFlZZ0VpUHpCODQ5MkRMUkpzTFFIdXpp?=
 =?utf-8?B?Q3lzWnVzVmI3QzU4M3BEMDlCejQ0eXAvQ1Y3RW1FeWxOWitzM1pNRWU4VW15?=
 =?utf-8?B?TjZDZWFsVUJMNmd2aTZPclpxT3hIRHMzTWtEVU9YRkNBQk1NUjVzRjlKUlo5?=
 =?utf-8?B?R0FiNjJQd1EzQmVVaDhxMFBCS01LYlJHWlBxdWF4OURmcUZJSmlLM3NFRzFR?=
 =?utf-8?B?STNXbng4SytIWlRQMnc2M1Y1TWpqa212K2luQy95VU9YVTZJbHdidVJQY2VV?=
 =?utf-8?B?ZWlPN2I1c0gxV0J2eEtMRG92R25DN0QxNTdTSWc5cHpMR09nVG12cTYzNGk5?=
 =?utf-8?B?RWJhT0MvNWRsQWNGUWdMSDlvRnFJY1hlM0YzWFRuY0lwSjFSTjFxU05PS09j?=
 =?utf-8?B?OWtVZ0RCUGJDd2dEV0x3dTFoekR6SzhSb0NwTTFuSk8wVWtEZ01saEF5M1Z0?=
 =?utf-8?B?dDZNNVhwWWdDd3RKNWJSMDhZRGoxT0J1cGJTWHpoRUIzR0s2YTU5MnoyRmU3?=
 =?utf-8?B?cHFWdmp2MW8zVkgwY3BUaHhFY09tZmNiWERJMG1uTWpLSWJOeXR2QUlOWTYz?=
 =?utf-8?B?aHlaR2lkQ3Y2QWc4dmVUZm54bjBuRWlpZ0F0NmJaeERCa3Bjc2trWUpuQi83?=
 =?utf-8?B?Q0lnYTN5UDROdVgxN3BocWtZMVlUN2dXVmVxdkVBQWtZWEdqa0tiT1NkOVRq?=
 =?utf-8?B?bHJ2TlFnS3dRS0MyYmZmZDlnQ0pkTTdRVzA3dElmVkV3LzQvdXQ3OWxGOVo0?=
 =?utf-8?B?QytQRkE3Nys5VWlDTStVbC81K3J5TmFhYzNGNExnUG1DUFdEekl5NFRYQ0N5?=
 =?utf-8?B?UWxqK2k5V2xabnNOamFEZnYrNTRFamE5TEhrczFmRk1tWFVobm1yWTFvczNz?=
 =?utf-8?B?Y1lQMDR3LzZ0RzEydVQ2RGpSa1hYVkllcFVsUm1wcEJLcVRiQ1RCczJWOFlG?=
 =?utf-8?B?RzNVdnFJQU5hMStNUUlOcFZkRE5Idk9kTXRWSkU5bGRKajZjd0Q2N2YvWWZx?=
 =?utf-8?B?VS9kbENVSDBLR0Q4Ym5RNkpuMFlsaVNDT0FXajR3K3h5QUdUUUo2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75791efb-22e9-4b6e-715e-08de75e309e5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 09:31:51.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekhXUm7RcN9mv9PnAfZUR+UlJPVQlZi28PCtX7junTDh9P3BaNW8SEPUARZxaEhJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78698-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,goodmis.org,efficios.com,intel.com,infradead.org,mit.edu,linux.dev,suse.de,redhat.com,manguebit.org,dilger.ca,suse.com,oracle.com,brown.name,talpey.com,samba.org,gmail.com,microsoft.com,dubeyko.com,ionkov.net,codewreck.org,crudebyte.com,auristor.com,themaw.net,cs.cmu.edu,fluxnic.net,tyhicks.com,physik.fu-berlin.de,vivo.com,artax.karlin.mff.cuni.cz,nod.at,paragon-software.com,fasheh.com,evilplan.org,linux.alibaba.com,omnibond.com,szeredi.hu,alarsen.net,huawei.com,wdc.com,canonical.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,schaufler-ca.com,amd.com,ffwll.ch,linaro.org,google.com,davemloft.net,arm.com,linux.intel.com,dev.tdt.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[145];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 1C7081B5606
X-Rspamd-Action: no action

On 2/26/26 16:55, Jeff Layton wrote:
> Christian said [1] to "just do it" when I proposed this, so here we are!
> 
> For historical reasons, the inode->i_ino field is an unsigned long,
> which means that it's 32 bits on 32 bit architectures. This has caused a
> number of filesystems to implement hacks to hash a 64-bit identifier
> into a 32-bit field, and deprives us of a universal identifier field for
> an inode.
> 
> This patchset changes the inode->i_ino field from an unsigned long to a
> u64. This shouldn't make any material difference on 64-bit hosts, but
> 32-bit hosts will see struct inode grow by at least 4 bytes. This could
> have effects on slabcache sizes and field alignment.
> 
> The bulk of the changes are to format strings and tracepoints, since the
> kernel itself doesn't care that much about the i_ino field. The first
> patch changes some vfs function arguments, so check that one out
> carefully.
> 
> With this change, we may be able to shrink some inode structures. For
> instance, struct nfs_inode has a fileid field that holds the 64-bit
> inode number. With this set of changes, that field could be eliminated.
> I'd rather leave that sort of cleanups for later just to keep this
> simple.
> 
> Much of this set was generated by LLM, but I attributed it to myself
> since I consider this to be in the "menial tasks" category of LLM usage.

Sounds reasonable to me, should get_next_ino() also be changed to return an 64bit ino?

Currently it is always only 32bit and we have workarounds for that in DMA-buf for example.

Thanks,
Christian.

> 
> [1]: https://lore.kernel.org/linux-fsdevel/20260219-portrait-winkt-959070cee42f@brauner/
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Jeff Layton (61):
>       vfs: widen inode hash/lookup functions to u64
>       vfs: change i_ino from unsigned long to u64
>       trace: update VFS-layer trace events for u64 i_ino
>       ext4: update for u64 i_ino
>       jbd2: update format strings for u64 i_ino
>       f2fs: update for u64 i_ino
>       lockd: update format strings for u64 i_ino
>       nfs: update for u64 i_ino
>       nfs: remove nfs_fattr_to_ino_t() and nfs_fileid_to_ino_t()
>       nfs: remove nfs_compat_user_ino64()
>       nfs: remove enable_ino64 module parameter
>       nfsd: update format strings for u64 i_ino
>       smb: store full 64-bit uniqueid in i_ino
>       smb: remove cifs_uniqueid_to_ino_t()
>       locks: update /proc/locks format for u64 i_ino
>       proc: update /proc/PID/maps for u64 i_ino
>       nilfs2: update for u64 i_ino
>       9p: update format strings for u64 i_ino
>       affs: update format strings for u64 i_ino
>       afs: update format strings for u64 i_ino
>       autofs: update format strings for u64 i_ino
>       befs: update format strings for u64 i_ino
>       bfs: update format strings for u64 i_ino
>       cachefiles: update format strings for u64 i_ino
>       ceph: update format strings for u64 i_ino
>       coda: update format strings for u64 i_ino
>       cramfs: update format strings for u64 i_ino
>       ecryptfs: update format strings for u64 i_ino
>       efs: update format strings for u64 i_ino
>       exportfs: update format strings for u64 i_ino
>       ext2: update format strings for u64 i_ino
>       freevxfs: update format strings for u64 i_ino
>       hfs: update format strings for u64 i_ino
>       hfsplus: update format strings for u64 i_ino
>       hpfs: update format strings for u64 i_ino
>       isofs: update format strings for u64 i_ino
>       jffs2: update format strings for u64 i_ino
>       jfs: update format strings for u64 i_ino
>       minix: update format strings for u64 i_ino
>       nsfs: update format strings for u64 i_ino
>       ntfs3: update format strings for u64 i_ino
>       ocfs2: update format strings for u64 i_ino
>       orangefs: update format strings for u64 i_ino
>       overlayfs: update format strings for u64 i_ino
>       qnx4: update format strings for u64 i_ino
>       qnx6: update format strings for u64 i_ino
>       ubifs: update format strings for u64 i_ino
>       udf: update format strings for u64 i_ino
>       ufs: update format strings for u64 i_ino
>       zonefs: update format strings for u64 i_ino
>       security: update audit format strings for u64 i_ino
>       drm/amdgpu: update for u64 i_ino
>       fsnotify: update fdinfo format strings for u64 i_ino
>       net: update socket dname format for u64 i_ino
>       uprobes: update format strings for u64 i_ino
>       dma-buf: update format string for u64 i_ino
>       fscrypt: update format strings for u64 i_ino
>       fsverity: update format string for u64 i_ino
>       iomap: update format string for u64 i_ino
>       net: update legacy protocol format strings for u64 i_ino
>       vfs: update core format strings for u64 i_ino
> 
>  drivers/dma-buf/dma-buf.c                  |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +-
>  fs/9p/vfs_addr.c                           |   4 +-
>  fs/9p/vfs_inode.c                          |   6 +-
>  fs/9p/vfs_inode_dotl.c                     |   6 +-
>  fs/affs/amigaffs.c                         |   8 +-
>  fs/affs/bitmap.c                           |   2 +-
>  fs/affs/dir.c                              |   2 +-
>  fs/affs/file.c                             |  20 +-
>  fs/affs/inode.c                            |  12 +-
>  fs/affs/namei.c                            |  14 +-
>  fs/affs/symlink.c                          |   2 +-
>  fs/afs/dir.c                               |  10 +-
>  fs/afs/dir_search.c                        |   2 +-
>  fs/afs/dynroot.c                           |   2 +-
>  fs/afs/inode.c                             |   2 +-
>  fs/autofs/inode.c                          |   2 +-
>  fs/befs/linuxvfs.c                         |  28 +-
>  fs/bfs/dir.c                               |   4 +-
>  fs/cachefiles/io.c                         |   6 +-
>  fs/cachefiles/namei.c                      |  12 +-
>  fs/cachefiles/xattr.c                      |   2 +-
>  fs/ceph/crypto.c                           |   4 +-
>  fs/coda/dir.c                              |   2 +-
>  fs/coda/inode.c                            |   2 +-
>  fs/cramfs/inode.c                          |   2 +-
>  fs/crypto/crypto.c                         |   2 +-
>  fs/crypto/hooks.c                          |   2 +-
>  fs/crypto/keysetup.c                       |   2 +-
>  fs/dcache.c                                |   4 +-
>  fs/ecryptfs/crypto.c                       |   6 +-
>  fs/ecryptfs/file.c                         |   2 +-
>  fs/efs/inode.c                             |   6 +-
>  fs/eventpoll.c                             |   2 +-
>  fs/exportfs/expfs.c                        |   4 +-
>  fs/ext2/dir.c                              |  10 +-
>  fs/ext2/ialloc.c                           |   9 +-
>  fs/ext2/inode.c                            |   2 +-
>  fs/ext2/xattr.c                            |  14 +-
>  fs/ext4/dir.c                              |   2 +-
>  fs/ext4/ext4.h                             |   4 +-
>  fs/ext4/extents.c                          |   8 +-
>  fs/ext4/extents_status.c                   |  28 +-
>  fs/ext4/fast_commit.c                      |   8 +-
>  fs/ext4/ialloc.c                           |  10 +-
>  fs/ext4/indirect.c                         |   2 +-
>  fs/ext4/inline.c                           |  14 +-
>  fs/ext4/inode.c                            |  22 +-
>  fs/ext4/ioctl.c                            |   4 +-
>  fs/ext4/mballoc.c                          |   6 +-
>  fs/ext4/migrate.c                          |   2 +-
>  fs/ext4/move_extent.c                      |  20 +-
>  fs/ext4/namei.c                            |  10 +-
>  fs/ext4/orphan.c                           |  16 +-
>  fs/ext4/page-io.c                          |  10 +-
>  fs/ext4/super.c                            |  22 +-
>  fs/ext4/xattr.c                            |  10 +-
>  fs/f2fs/compress.c                         |   4 +-
>  fs/f2fs/dir.c                              |   2 +-
>  fs/f2fs/extent_cache.c                     |   8 +-
>  fs/f2fs/f2fs.h                             |   6 +-
>  fs/f2fs/file.c                             |  12 +-
>  fs/f2fs/gc.c                               |   2 +-
>  fs/f2fs/inline.c                           |   4 +-
>  fs/f2fs/inode.c                            |  48 ++--
>  fs/f2fs/namei.c                            |   8 +-
>  fs/f2fs/node.c                             |  12 +-
>  fs/f2fs/recovery.c                         |  10 +-
>  fs/f2fs/xattr.c                            |  10 +-
>  fs/freevxfs/vxfs_bmap.c                    |   4 +-
>  fs/fserror.c                               |   2 +-
>  fs/hfs/catalog.c                           |   2 +-
>  fs/hfs/extent.c                            |   4 +-
>  fs/hfs/inode.c                             |   4 +-
>  fs/hfsplus/attributes.c                    |  10 +-
>  fs/hfsplus/catalog.c                       |   2 +-
>  fs/hfsplus/dir.c                           |   6 +-
>  fs/hfsplus/extents.c                       |   6 +-
>  fs/hfsplus/inode.c                         |   8 +-
>  fs/hfsplus/super.c                         |   6 +-
>  fs/hfsplus/xattr.c                         |  10 +-
>  fs/hpfs/dir.c                              |   4 +-
>  fs/hpfs/dnode.c                            |   4 +-
>  fs/hpfs/ea.c                               |   4 +-
>  fs/hpfs/inode.c                            |   4 +-
>  fs/inode.c                                 |  46 ++--
>  fs/iomap/ioend.c                           |   2 +-
>  fs/isofs/compress.c                        |   2 +-
>  fs/isofs/dir.c                             |   2 +-
>  fs/isofs/inode.c                           |   6 +-
>  fs/isofs/namei.c                           |   2 +-
>  fs/jbd2/journal.c                          |   4 +-
>  fs/jbd2/transaction.c                      |   2 +-
>  fs/jffs2/dir.c                             |   4 +-
>  fs/jffs2/file.c                            |   4 +-
>  fs/jffs2/fs.c                              |  18 +-
>  fs/jfs/inode.c                             |   2 +-
>  fs/jfs/jfs_imap.c                          |   2 +-
>  fs/jfs/jfs_metapage.c                      |   2 +-
>  fs/lockd/svclock.c                         |   8 +-
>  fs/lockd/svcsubs.c                         |   2 +-
>  fs/locks.c                                 |   6 +-
>  fs/minix/inode.c                           |  10 +-
>  fs/nfs/dir.c                               |  22 +-
>  fs/nfs/file.c                              |   8 +-
>  fs/nfs/filelayout/filelayout.c             |   8 +-
>  fs/nfs/flexfilelayout/flexfilelayout.c     |   8 +-
>  fs/nfs/inode.c                             |  54 +---
>  fs/nfs/nfs4proc.c                          |   4 +-
>  fs/nfs/pnfs.c                              |  12 +-
>  fs/nfsd/export.c                           |   2 +-
>  fs/nfsd/nfs4state.c                        |   4 +-
>  fs/nfsd/nfsfh.c                            |   4 +-
>  fs/nfsd/vfs.c                              |   2 +-
>  fs/nilfs2/alloc.c                          |  10 +-
>  fs/nilfs2/bmap.c                           |   2 +-
>  fs/nilfs2/btnode.c                         |   2 +-
>  fs/nilfs2/btree.c                          |  12 +-
>  fs/nilfs2/dir.c                            |  12 +-
>  fs/nilfs2/direct.c                         |   4 +-
>  fs/nilfs2/gcinode.c                        |   2 +-
>  fs/nilfs2/inode.c                          |   8 +-
>  fs/nilfs2/mdt.c                            |   2 +-
>  fs/nilfs2/namei.c                          |   2 +-
>  fs/nilfs2/segment.c                        |   2 +-
>  fs/notify/fdinfo.c                         |   4 +-
>  fs/nsfs.c                                  |   4 +-
>  fs/ntfs3/super.c                           |   2 +-
>  fs/ocfs2/alloc.c                           |   2 +-
>  fs/ocfs2/aops.c                            |   4 +-
>  fs/ocfs2/dir.c                             |   8 +-
>  fs/ocfs2/dlmfs/dlmfs.c                     |  10 +-
>  fs/ocfs2/extent_map.c                      |  12 +-
>  fs/ocfs2/inode.c                           |   2 +-
>  fs/ocfs2/quota_local.c                     |   2 +-
>  fs/ocfs2/refcounttree.c                    |  10 +-
>  fs/ocfs2/xattr.c                           |   4 +-
>  fs/orangefs/inode.c                        |   2 +-
>  fs/overlayfs/export.c                      |   2 +-
>  fs/overlayfs/namei.c                       |   4 +-
>  fs/overlayfs/util.c                        |   2 +-
>  fs/pipe.c                                  |   2 +-
>  fs/proc/fd.c                               |   2 +-
>  fs/proc/task_mmu.c                         |   4 +-
>  fs/qnx4/inode.c                            |   4 +-
>  fs/qnx6/inode.c                            |   2 +-
>  fs/smb/client/cifsfs.h                     |  17 --
>  fs/smb/client/inode.c                      |   6 +-
>  fs/smb/client/readdir.c                    |   2 +-
>  fs/ubifs/debug.c                           |   8 +-
>  fs/ubifs/dir.c                             |  28 +-
>  fs/ubifs/file.c                            |  28 +-
>  fs/ubifs/journal.c                         |   6 +-
>  fs/ubifs/super.c                           |  16 +-
>  fs/ubifs/tnc.c                             |   4 +-
>  fs/ubifs/xattr.c                           |  14 +-
>  fs/udf/directory.c                         |  18 +-
>  fs/udf/file.c                              |   2 +-
>  fs/udf/inode.c                             |  12 +-
>  fs/udf/namei.c                             |   8 +-
>  fs/udf/super.c                             |   2 +-
>  fs/ufs/balloc.c                            |   6 +-
>  fs/ufs/dir.c                               |  10 +-
>  fs/ufs/ialloc.c                            |   6 +-
>  fs/ufs/inode.c                             |  18 +-
>  fs/ufs/ufs_fs.h                            |   6 +-
>  fs/ufs/util.c                              |   2 +-
>  fs/verity/init.c                           |   2 +-
>  fs/zonefs/super.c                          |   8 +-
>  include/linux/fs.h                         |  28 +-
>  include/linux/nfs_fs.h                     |  10 -
>  include/trace/events/cachefiles.h          |  18 +-
>  include/trace/events/ext4.h                | 427 +++++++++++++++--------------
>  include/trace/events/f2fs.h                | 172 ++++++------
>  include/trace/events/filelock.h            |  16 +-
>  include/trace/events/filemap.h             |  20 +-
>  include/trace/events/fs_dax.h              |  20 +-
>  include/trace/events/fsverity.h            |  30 +-
>  include/trace/events/hugetlbfs.h           |  28 +-
>  include/trace/events/netfs.h               |   4 +-
>  include/trace/events/nilfs2.h              |  12 +-
>  include/trace/events/readahead.h           |  12 +-
>  include/trace/events/timestamp.h           |  12 +-
>  include/trace/events/writeback.h           | 148 +++++-----
>  kernel/events/uprobes.c                    |   4 +-
>  net/netrom/af_netrom.c                     |   4 +-
>  net/rose/af_rose.c                         |   4 +-
>  net/socket.c                               |   2 +-
>  net/x25/x25_proc.c                         |   4 +-
>  security/apparmor/apparmorfs.c             |   4 +-
>  security/integrity/integrity_audit.c       |   2 +-
>  security/ipe/audit.c                       |   2 +-
>  security/lsm_audit.c                       |  10 +-
>  security/selinux/hooks.c                   |   4 +-
>  security/smack/smack_lsm.c                 |  12 +-
>  195 files changed, 1101 insertions(+), 1166 deletions(-)
> ---
> base-commit: 2bf35e96cf6c6c3a290b69b777d34be15888e364
> change-id: 20260224-iino-u64-b44a3a72543c
> 
> Best regards,


