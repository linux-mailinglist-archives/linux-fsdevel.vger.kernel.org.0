Return-Path: <linux-fsdevel+bounces-30354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E9198A3A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C42CAB279B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEAA18FC81;
	Mon, 30 Sep 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y9clzkpy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AjEHNRMZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116618F2D4;
	Mon, 30 Sep 2024 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700923; cv=fail; b=BU+oIVqLze+GGr06aK0zx86/197CnxcLhH/xx9qJpTp3t5iOpCghJFkamTUSNKBxUz2lPqvsY1GSG3qUieLap1iPwoRV9xGIQxapf09BXOfkJlWi5uIAKlwWoEh9p4uBatoSwRo/cAPHgpCXu57bZtHYGj3v/7FUNEkHTTv6MnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700923; c=relaxed/simple;
	bh=wGM+4OH899Or67C4IM4hVY5UHwUQQ1QwtZQPWYOAgOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p7jOlUhftweMQiJk7XCHR9ZVjcQXIk3+OhrslzwJPhTQ+WQF4K1UF1sxG8XdD3U+sXME4nQgDTElTnXz6ADCuHC67fak0mhx+KbR28A/C5/3X92DnFb7dH8XkJtbr18wnIwRuLIjx7I3RiqIxB7X2s+uwTCof/jIX+5yII2adUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y9clzkpy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AjEHNRMZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCSwnu024634;
	Mon, 30 Sep 2024 12:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=qd7RpKbCyqRzKeltI/Gx0fICIwkxogjEJMxet5EbvYw=; b=
	Y9clzkpyJOnBWCsGxC2G9uAiGTV/YQz4X5VUZ0Z48wavbHmf0Gp+apapKw/bYvoU
	UaJXDK1XY1pqkWo5sngTEzGlLfRe1H32AsCZZHZjkTL3L7sx3D5wNWXoxYaDG6WZ
	5pYY7MXMJ4LL29CCCxh2/eqYaqQx3INs0nyypMCTBv1IA3zbgzz9l/CKZZkwJfhH
	jxwUMDf1cNBXLBPJGZHevIaOSFEAeWLhxWLjYumowlWgsBH+nDldZMhhsvsyPnZl
	VixHVxWyiAjEOUhCtdpBcKw5cYiPInT3/O6k/Kp6LBBtKH0RU00u0Xdl+K0ce6T0
	zFcKz7JrOet3VCTsElPA8A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87d37tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:54:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCXPEV017246;
	Mon, 30 Sep 2024 12:54:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8860b6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 12:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MROBKj7MYHOiffi/aWa0Ltpq7pRBcsuhR7lFsxP3KPuZr+MbIg0IhBGbxEhhKNwOUQFlaOZjNqgn1OjliEj0RzYBC13LbZXs9acLxXXWGhjSFVx8RAKje7NaUnmoimsSkSoRTXlkus0ceRJ1REsWklmJIBryWSG4lND/55z0hanKMy6UFjpisl4iMt2IhoZzAo+N866w95avEZE+MkxEjlCfi9yntEcXg7Cr3IPgpa4FM08XfamvA4pSRp+PFzZGkAKckbxO5Rze7DfQWbpcWnyjWFdYi/Non5Z2dW0vJIzr4aO+IB+btTZLVO8oVGu3t7pOUC8wmAqMMusvWOjqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd7RpKbCyqRzKeltI/Gx0fICIwkxogjEJMxet5EbvYw=;
 b=S5h8XFbgnalLRtAEB01NZ6rDacJn/vMhObdZJon327N93hLSL2YcqK0/3OZFVXqj5KGCkqmkGdiOA7to7c7uT0a/2a8KPZn/TLIcwRJWS+hsoGumZufOzvHW1ODVC59/TwQBzibXglZJwf243/o23NDKj5PTt6wJ7Wscg+9zoE9/I7Ux81r0eGvULyBPQBkWu7f8ugxBVZa896W8ulu+v4Y8/7SUcM1CSeWmbDAimUiIcY57XK30cQyp4cHYkTTOMed1Ajy7+DU/qwwkfSF6LFz4gZCrT21KmMgb5+LyddXOKOvwRaElrtiLasY1rM01mUdTWCfoofnG8tmqkTmlwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qd7RpKbCyqRzKeltI/Gx0fICIwkxogjEJMxet5EbvYw=;
 b=AjEHNRMZDOPYY/mXNpZxXfAvJI92c8tES3MEnl15WKgKlhAGswIkMtF5yEme4Hq8H+nYhOnmQlVxlEq3umUedZa33LPeXfuBwPs4PKM9AXyXDReHiPpkXSsKkUagNr6833lEsQ/Qglq3S/lAuqLcB5iBg212nWjLQuHVzChVcsc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Mon, 30 Sep
 2024 12:54:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.005; Mon, 30 Sep 2024
 12:54:54 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 2/7] fs: Export generic_atomic_write_valid()
Date: Mon, 30 Sep 2024 12:54:33 +0000
Message-Id: <20240930125438.2501050-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930125438.2501050-1-john.g.garry@oracle.com>
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4472b1-3f49-4857-8429-08dce14f14bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8C85gkQmDrOdXDb+r94rv4jMyaDpr9EX5Pfsyu040y4XKdPo4tH23XD/fH4t?=
 =?us-ascii?Q?IAguKh0NhqfG054nU4jwvDYxcvxY8Iyh6Z2J2PrynnhmCCKldTcNQXqXCgnc?=
 =?us-ascii?Q?S9xBOzK3jkmbJVDHOhBC5D1fR71GzhTzrs+C1vjpmWrlmJw42mZQD5whTlXQ?=
 =?us-ascii?Q?9IZfr/bJkWHML6PK+LMRPzDj/5fQHMONaiARjR0WDdPsbDTOj4XwaAst8kH5?=
 =?us-ascii?Q?7+VyoDuI3V9n0A7o2Lz7X3ptiE0bCegXDwm8A4Kz8+b1bfESmEWNmznHFHN/?=
 =?us-ascii?Q?VJ2UCakQI4EkXuXeu2s1xAl65120EiAIOsT27rtqfPg5hPoFvAfQAGi/OJFo?=
 =?us-ascii?Q?MBdSS6n6/IY6npxt2dHMO22vdDbfWPbnA7RLVJcAhgTB42kNdxL/+5u4IjfT?=
 =?us-ascii?Q?rlqGgtt6y+Vn17SrCauWHDjoGUVx2LkE4DajjTx96eZKueiUrCau2wVtL8ZT?=
 =?us-ascii?Q?rbz7wpBt3ZJte3gRoo0l7LVIMHidXFOW2E7KjQdvUPi6ttnoW0C9qoEHDlfw?=
 =?us-ascii?Q?Ml//xXefZNGKo2ZdOPI/YdkSa9+07CDuIctztEqAdnZB6puN7jIINhrsmt86?=
 =?us-ascii?Q?qQxiN37dC91uZtloVz2kEHqpFfTX3+ZjpQ97RQO4FPgFe7zG6uFiHnZG892f?=
 =?us-ascii?Q?Pe+55f9psQP9HoXcsPVpSHQnj3uQ+yX5QmzkDgaqdBekoPU9wtYvPmnhTGxl?=
 =?us-ascii?Q?5cToIqcZon/AK0i9sJ1V6m/aN/ckyEJRElm/w/PWma0NckY0BN7TzXfhv/xq?=
 =?us-ascii?Q?YOyH9UuBxaExWoCC2I2K9HIiJlkIx2SAYBiA/xjSLc0vknMjXzOYue9DJPYh?=
 =?us-ascii?Q?s3Rh5Bxx68RFcfVSIqDHITc4tRyBbnp/QfL7YBrsz14pt+KwWEWPvHskV+bL?=
 =?us-ascii?Q?9RAYTmwz33Mc8gUZpZMz/oTL4UnZEJnoYcvz2T16ETZshQf4qmt+R84OVeCs?=
 =?us-ascii?Q?sgAATvozklXFk/JQ69XvAtUY9LDx7LXgvxBlEDJz7EqPdGxmzRmCQX5vT3Te?=
 =?us-ascii?Q?Uomt4uTH2KLEO3EfJ9KtZTbHyTorGjMFUx0fg/vrt4S4d+7Ka7qEq/V6JUM/?=
 =?us-ascii?Q?q4Q8D8uinTSIptROZ4PYttIial3GnfgQzQq7YuRbwQSaI6v0XIpeH+vIr3WC?=
 =?us-ascii?Q?Je+DT8++EGqjsQVG2emyDzyg1kkOWXnS93lKgTMs3AjH0Q4Q7WEyn63vqddX?=
 =?us-ascii?Q?zBzqUxQ6tEeap9LEVzhVy9VZQxRq1VcnkkGawbwjwSKtHTfc79t8j+zu7+AI?=
 =?us-ascii?Q?EtUP5Hm3bA4Gcd40E/4Is54+V0go0LsZyu9PLOeUfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y9KMLmtAS/0sviLpe4XHPk9i6+H5p1prdB43YXHhMcQMILJYcfj1EgZWG9qR?=
 =?us-ascii?Q?/5zYS5u4z0MB/OYv55K1TTdjAiBFE/EroxTjb9BU5vyoRNqBYl1qrC1ZhLx9?=
 =?us-ascii?Q?4tuu626LquR5HViBdg/ch4anVOO4EyUM2m2xWL9Nu7XXX7mw7c588pkmZ+et?=
 =?us-ascii?Q?v9ecQVEXxAQEcN8do9dEmP2vFYNWxRg5EzPpycOidgFzpYCNkzN26e+taImi?=
 =?us-ascii?Q?mlyZkbvO4S1X8rwWY+PwCCUL9eXRaUW0m4bxZU10GiTB2YdIEGHNbw/lzrAN?=
 =?us-ascii?Q?XF6TK/77gF3TGk9vyYINDxhUy2MMDZemH6e43bOtIKVd5BiKHtPxFTJnIyFZ?=
 =?us-ascii?Q?yCQ3l5ST3r1/CJYEQFfQqUP2gOJBjFsCI6EhXkW42l0XVKehf+AoWuNV/yrw?=
 =?us-ascii?Q?FmsL/JkUjskQ4S6ie/ha1APbH3eGs8EuNOLTRrF7FzUZlMChpFWQYvu8s0Nm?=
 =?us-ascii?Q?54RQzZ6o0wkFF1rJ2fAAFcqqu2O+SsUXDk5kGP/OABPWgmdxwA1ADRx8dfoS?=
 =?us-ascii?Q?CfNf3OlSCetWn6SJqb7PbW/AoLoR04tub1ofRQ2M4K3S1axrOkUOMK9zlZce?=
 =?us-ascii?Q?LNtJfx+rcHgpG9LF6XCFm78LHBZZWCxfj47hai1qEmUPQ+cPJyocbUrJvVVw?=
 =?us-ascii?Q?FUv4tHicrJbNPmOz3nkrD1SvXTpnSAcWI6ZbClanPVcRTpugqvGlNJ+rvrFx?=
 =?us-ascii?Q?uR2oxyPyngU7HJpuwjaxmqrc5n4GdeDT8RFrfzJO04KQK1Vu1E0UyvqOyfJV?=
 =?us-ascii?Q?tkeN66aXl6owXcg10vC1wZYmVUWFJeTvgjW/Db0xSxVy+9UYDUeSot0C3HOp?=
 =?us-ascii?Q?6FOjKYX9IfkL/F5Ms3wImPMqoBAJLL9W+Ob3Uds2RSLVjanJyw31oAMSpm1m?=
 =?us-ascii?Q?U/jq1TEPRITtipcrnM5nSOAXPDXUnsgxFxZgwCpC8jTvVKeiH2QNpIB0z7qy?=
 =?us-ascii?Q?gCIM858kJ22j3g0tax6PEcNudQgWl7Hfw8EwD7x+0clvzpXS4w3vnnK8tO/h?=
 =?us-ascii?Q?aVGJmlsT5OAjFrxZN4G9uxKLCuEmgUH3ILZ091Dhrf/7DyKcCoYjwsZzjZs0?=
 =?us-ascii?Q?1LjUtSzaFeNeeWB5Dlf6igr69AtUC+DEc9JY/1Ej/TPSOYmyfoKUJ+cBVZHr?=
 =?us-ascii?Q?qcmGMzaIWPquN/b1qKGhCx5XeXkCr0WFufVzV40bdE09DdXagPZDFHCI4GSl?=
 =?us-ascii?Q?lPlmbJhEZDXknYiR4oD7JgR4W+ISCWQIs77u8lTfjC3W+rAtV3CpB7vEuvv2?=
 =?us-ascii?Q?pY8es2cSPmdknOUhnfoga6ptDW0SMe4NqxBMJQoaG/tRn4M19ajYvDk2KvbS?=
 =?us-ascii?Q?M3dhUoRJl5VjxJBNwTxQsf8Q4lDjWYGyNq+mh+Yrau+lG5KnFcKunYg+2pd9?=
 =?us-ascii?Q?ju806dYGvvBqTullCBBCV8q90bocTgXmSGy8Mg8YdjNweVrPRQpQ764friCK?=
 =?us-ascii?Q?Xm8Hm9wS2PKyZU2OIDKaod0y1uvDqgAuCEHtRBR/77XeoAcAv85HZsGw4lFp?=
 =?us-ascii?Q?HRCDu3w9a3SYZq4EeImwUqwwkZ+yjHuJzCEOsxzCrz88EVPYq3XvbDCYzNJN?=
 =?us-ascii?Q?aTpTAECHVyg8DARZQbmJ2PLCprnVobr9VLktVY1gK/RavV1KqVxd2zXnVhLa?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JgmEsYgilxTcNyU8+91cU9FAX9wMA15U68JxSWTquUbR6n5eIxqV5JDmG/UMBs8Z0yznVzgAqZ/AqNV4qlBOKQ54D4dV1X+/AgVZuqXA3yrTvPoL2ZCZw8VVakHB/uNJPzIN2dcI3bP18BmyBWYJP+T1guC5MnXrkturUBpbd2yIodThBEoWl4XzCkxyCnMCIGr5lhzgmmsWPgEG0492+J66osYEarbJH7bx604B6cF2V4uGxHNqNAHUGC/58CRhYMnlUWxGfBJkW5kXWD/xFvveKXU+2AV31n/QgtgbrAloiUIv1m0CsLafHRuz1/v2l8jANAdiRXU9zN0Ma8c0tnlWjAwAUr+E3CuvdaLn1TXpzynBIIbKYBmYMoBek3c9/i56Q9tfoVp7VzmQ3OvfAnyYeOxGLqP7TvZdr6n9HORWTu7FkLVq8H50DVLZYp8cFj6aq/z3aam1yGeVgD3EHK2wa0yseD/tZ8sGqFHnp5pW/HOhWOfjjT+EUdiMSeL2jJNByxAfZDvQgt74ghEqPKvg8xnf8Ws/UP0Oe9zWVqOjgSYiwmfNoSq0LrxJQBNog3KDa3Zq4xGtjkkdmLMc8qjuqR8qRfgcBsUj7Z0ug2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4472b1-3f49-4857-8429-08dce14f14bb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:54:54.7256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMfLAdk1uPBaCBtJVmpyQfz2YwyPim6PfM9yTWjDd4ym6kjJPqXs8OjerJU1+eN+m3rj13RX31thv/sMikN1Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300093
X-Proofpoint-GUID: 0BdEKGFLlJNVn7hChRfW1zbFp2Q5Q2rF
X-Proofpoint-ORIG-GUID: 0BdEKGFLlJNVn7hChRfW1zbFp2Q5Q2rF

The XFS code will need this.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/read_write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 2c3263530828..32b476bf9be0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1845,3 +1845,4 @@ bool generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(generic_atomic_write_valid);
-- 
2.31.1


