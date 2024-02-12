Return-Path: <linux-fsdevel+bounces-11248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 328268521C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7431B2112D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C914F610;
	Mon, 12 Feb 2024 22:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XkapfqvF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LmImTAaw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC34EB5C;
	Mon, 12 Feb 2024 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778447; cv=fail; b=iYDBS9nM/S7M+jkXpCNccWIrrh9vr3JGH+uR9OPEty/46WUYj63u/BrJKzi/Mzylm1JX2/obK3Dl4Bhh3jv1Jij4D3psgonA9RcQNPiFjQKQfgHS8y35ukmZIgDmS8puUQngMbvg9sOrjpc/Gh6h0AvIVnN5oyIIGzLcp7kSZBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778447; c=relaxed/simple;
	bh=XQ5g6KRxV7QTGjc/bC8N4Yx2KfxHWo8XiODd4R2GSHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rw4ZFwdkSlCega1zcjVSjFIefK+nuhtKVPIZidt8OuBLY7cVaalJdlTtazkQg3a4jmGgbq2VPifQnHe4bl2i4dfatx8FhJEDLUMaqPaTTAr4uXzhb/hUgB3pJKhhRUKMnPZDCwooYx7uPunVNj5nyu2DY6updKxigkm5SurWQ8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XkapfqvF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LmImTAaw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CLJdLC018740;
	Mon, 12 Feb 2024 22:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=VhqWbhlRJD5NwguMKaSXCJ32ooMCAeUIspznOjSq4Ac=;
 b=XkapfqvFRAQMC7vRVWC29m/ExD+WMExBubqF4h/f5eNLPslsPomB4v8fY6X7g1Fb5Ntz
 jSouFfXvFb/szkSqOrxG36LVeF+GhWMP1/wIbH/aWCBUjI9iTs3WE7FTo2DkSGadE+Y9
 d0ARuZDrwQ6JewOsvo/rGdL5qlys90zCqdC/sORyaf4+RPqQxuPKoR5bt/Cylo3Rv4a6
 cAWR0WvoTYFkruaWkq71LBIT4/seAJU7WAYPCir3bsY6mNNg7V4pcMp020HrQz4uTKMo
 vF300ktvA8x/BAYH5pIdXsqNhJvcrESHVpPxU9jmwiAtST5bRoTwzpDr218vvO3FOO5v Tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7u53r5wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 22:53:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CMlbDF015414;
	Mon, 12 Feb 2024 22:53:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6fcvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 22:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7hKdbazWRl3H3hEFFLOfPF6N6asgfmPGoTnAxtz+8UZDRErQwoLUiml4R1XCIpw12td8wWnx1h+s0ue+Od7IdXZ8XoFjarcz0d6e2JFwnP6MhpfFwOPyvQk/94KDo1GDhYv8V1/f2eF1X7kFblUbKJ7m6OBQ4Wa3uz5oldO28tiPYSWFpHq1X7R0wGKhOhvrxcV7TgCI/uV3wIHA1+5Gw1FeFbewGkZpejJGQlGblRa0uQSMqcDiek0MUZXCvis8DxYjZiXr+dJIMNLvd1g9AOtKdyuWMBxS6oxYM50B1MlYq1vbnlIPcwkj3vEqc8m0HFHW0CKZIKvzY2aGZI6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhqWbhlRJD5NwguMKaSXCJ32ooMCAeUIspznOjSq4Ac=;
 b=fXZOXnoULhVMFRhVd7x4DBosTDmfYGaapiTs2XA05T/X12fQ7YZd1mDI2byG3rz0HODL1sS0lq8hH1EqCxTkZ1hQvQX8O0PKJTsdvNKUJTStPg3vjzjIxWjahwkE0EBghf04Ow0gWjcVoSBMEtnKxgDqMQB6TlPEWDt598VYDjvl5TzcjUpLnIJYxf0khfWpUf3AGeWS5S1kiimVEvTF4wAWBTdo21D325SgFtMk11izNxaV6mAwcD3LsuOhEThFb2h3XxE1Uaf3e3hn6PKYDSXGL06rIRYAbffyY5tBuQLVFPXj41i1gF1Znmm37Tq3+q9ViPtDk9KjlmgKh0bL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhqWbhlRJD5NwguMKaSXCJ32ooMCAeUIspznOjSq4Ac=;
 b=LmImTAaw06DVIzICTWhJgiJX5g1fWMpwSryqCCTxZVlvs7pYFjaSXvgrtO80Sr1DLtT5QSPtZdOv9rbVMXjt88scIVISMXnoxpZ6bzzPB2Ah+DSPX+eNn2QXziVhCKDrNB7a4CMBUJ/jh+u9g6JjIyk/VdmNXzSEuOSnT/70sqw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7166.namprd10.prod.outlook.com (2603:10b6:208:3f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Mon, 12 Feb
 2024 22:53:15 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 22:53:15 +0000
Date: Mon, 12 Feb 2024 17:53:12 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v4 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240212225312.eq4aebhukeor5g3h@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240209030654.lxh4krmxmiuszhab@revolver>
 <CA+EESO4Ar8o3HMPF_b9KGbH2ytk1gNSJo0ucNAdMDX_OhgTe=A@mail.gmail.com>
 <20240209190605.7gokzhg7afy7ibyf@revolver>
 <CA+EESO7uR4azkf-V=E4XWTCaDL7xxNwNxcdnRi4hKaJQWxyxcA@mail.gmail.com>
 <20240209193110.ltfdc6nolpoa2ccv@revolver>
 <CA+EESO4mbS_zB6AutaGZz1Jdx1uLFy5JqhyjnDHND4tY=3bn7Q@mail.gmail.com>
 <20240212151959.vnpqzvpvztabxpiv@revolver>
 <CA+EESO706V0OuX4pmX87t4YqrOxa9cLVXhhTPkFh22wLbVDD8Q@mail.gmail.com>
 <20240212201134.fqys2zlixy4z565s@revolver>
 <CA+EESO6=tVK6xUGTHG+6yCUGarXb_vHmjOuqEQ_d4gCe8V3=xA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO6=tVK6xUGTHG+6yCUGarXb_vHmjOuqEQ_d4gCe8V3=xA@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: CH2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:610:5a::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ad2aed-80cc-4ba5-7299-08dc2c1d65e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JtWp0feZeslz87j9oRu1wXpIK0XvbXBgexV/Q7bH/b8ph8LryeXVLcnzjZR//57SnD9KIw5LlqNN0deEK9gvp8rgOrf4ce1uQhAMqk5ghBbQTdwBaDQ6maXmVYcJxzV67IRU1lwJasZxY/Sf40T7hWToqZYyG0golUfm3Jga0kGeZQJcwNxUfmAA56zsaC9PTgCdGBnS0JwIqeoeJh/dFFidwK+OM4J1XSoYI4yiWeM6oT7WPhstakhnIF3z/Ll8BR3ZHu88aspUco+3JeVRV4P3HVghr7KvxEtRox+CQoh458n3dhTets/JZ4UpaxeoQ2s2OIznbWxhFh/Ndr6Nb49U+ph4zw4r6ymFwhtBq3zUKfufJWEJTMLHqXLyWDDKZYBAujyBd1NIhlwi9axJ+Rwy3NNOCuq72JihbqaKqnU4NHbYAoWToA/0NLqsj9SclPiWAskJSa/opNqLj1jR2CTtX/xGhYvlTgNqyMZ1pi9qduCk8/TfKa7Um067OkfPvMwck+qzUKFdCIpmlUvudecWDBs7r+V5vv0exdzRuInxgVRXo/1FFgFyJ+WwU5Z3
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(33716001)(4744005)(7416002)(2906002)(1076003)(478600001)(41300700001)(6486002)(8676002)(8936002)(6916009)(4326008)(26005)(83380400001)(66556008)(66476007)(66946007)(6506007)(5660300002)(6512007)(9686003)(316002)(6666004)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?x9I8kUJ6i76O9VsLQJepFLq5A5KRNyYRiIevtRaz7V4Aw5bf71oeoNT8p4uu?=
 =?us-ascii?Q?SkmMqy8AGhB7cyNCszErvN6oXTfT7XUdmTdYFUdFl0d3ahZlPj3MhodBNNlP?=
 =?us-ascii?Q?l0C649pGVQjCER6W2KDhOlJLA1iKIMm/rBeJ0k0BtU3hKc9begMC0i7bPey7?=
 =?us-ascii?Q?Wod0VtRCik+KLPhGwkXfLFkcWCL/ZW6mkxL9QwRcooCZB/aCCgieCYbwFpjh?=
 =?us-ascii?Q?NLm0SZ44al+Zfmza2MP9R/9DOp1MkzX29lNqU/sc7z/rDesf/mI1cZ6yfrBX?=
 =?us-ascii?Q?k/VivwqbVZHwc9hKnuEN/B6dlNJimV6XTZV/ZAWRyCFBF6Eu2WR3URWW9Bz5?=
 =?us-ascii?Q?LotTO/ilLiwACALDU/N3VdgY7LjEVVxngwQTihcF3T22MBiinWDO2Cg+1r2v?=
 =?us-ascii?Q?bksTGxLKnkJYDHS39t9D5cdGerX3zL3aDMQNvtXEFIAFMsiT5Mvv2jpzv1Zs?=
 =?us-ascii?Q?rm+S534Y3KlxrgLH2hsiF++aY9VenP2XMON4KdGjX4BtbK+iRrm5ACL5510y?=
 =?us-ascii?Q?gaczYn7uQnHmDINpzHlGniclxUFvng7rq+7+Qrq2b31RUKiml8CXEMs1sCEw?=
 =?us-ascii?Q?f3RrdZVH32DmloyToR610Bm9tM0IYd98aUOlEL1sXWFXvYaWZVESs9ITDQ5Y?=
 =?us-ascii?Q?BeaqSNR3VkwkL8sHa8p+pGk57Szq/lZ7Sm1G7Sg7NtBMcGWAbW4fypA+kx+4?=
 =?us-ascii?Q?RjtTwiEmdKHARnM31hE8EVY1Q2kdyN/uGLCUM8motL350smsQ48Na7zy8MMi?=
 =?us-ascii?Q?J9RTHpX9MwshdiYKnhdvWQpHcpQlU2vEu+zc1N8KkzBeMKMg0lOLrzOYNt6J?=
 =?us-ascii?Q?SdQetLvibTCmELVhtXaPfX6Zx/3gc/SyEL61+4E2m+9X0JS/o7dpszf8fkIj?=
 =?us-ascii?Q?PnY3rdanWw4Oe5gwv+w64rJQbJYWQTN9w10PoLdsKJ+oGy9h6E3t8F9AJtVa?=
 =?us-ascii?Q?dxOry/B7NLMF+852Tqo+E8h+cIcnxHLZMv75f4shYvizhMfBfLoU8iBn+mJG?=
 =?us-ascii?Q?jl7b2TAevMHt7vjY/XE4zk/7Qd8yavcI5xiKMwyY57IKneMIE03pAPy2TKWQ?=
 =?us-ascii?Q?iFulS478chefujoNE/AS5WKUHQP3KhdRfrTOFBMdiFE6Mo8IPs/5SFNzQ+xw?=
 =?us-ascii?Q?JWzPl/Ij/kjDeAL0m60a60DH6nbFzV27CS/eY8YNW+wQJZxxH6LX/6LZgI84?=
 =?us-ascii?Q?go/oIdJ+wy5wngCzWCbTRMULH3Rt/atVgurIHHIoZA1q8XThfeND9wtytjnM?=
 =?us-ascii?Q?6yDGSV6EhSTXrA9ldeD2sBwAERHo5FIUbD+hEYpa69qOUp9dmiVbD6/NZC8i?=
 =?us-ascii?Q?k3/5Z5S4BUZ6XN+eIDk7Pq4jwr4odSSLxcFx2aoFSxwO87XRNtgx6Jn/sVnN?=
 =?us-ascii?Q?LlZmyfyyBx0LK4+OfmVzHnqbn3okovkct/InkV3nyDI8ikW4IhDWmjjaCfgm?=
 =?us-ascii?Q?kvRX8OpDwdHx+SIquzZ8yb7QlwQvkY/LnUxiLRDwgznWYKZoyrSy6EJIhoYo?=
 =?us-ascii?Q?ucCogRkRLNKKTRwti9+oyu9TRm9eScMK7FSzcDomEwwYybGFa7seknQiQgyO?=
 =?us-ascii?Q?ntBoz8Da8t/w9KoTbV635+3dy6txWMv9KkZoEvvU9GgIWP4TDjCqgftyQyHU?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CF7dNrwUrOj6W+G8VCofQMy912OnPfdqaTydc4bGa2jtu/X9jmhTqJ8pgZuKB+ABzhNjXZ7vg1Nk8JWPDbHZ7k8Xma8Z7AZeaxi/opYPYyGEg/l0y3ZXdAajq9QCDVAWfi+u6olYMsUk2I6tICu/7b9Dh34eXMnG5ZPpOl3AfWOXZqhDQac9ULWf5Qsua/17yZqtcUM5uRrHJ6Hds0hKbxgUsZE9DnJ9s8MjGLh/3r4Ds+yGUkwyNNKRaCPJ6XVOttV8aSXGWsdmuwq0Tqppuj1WmxivhF3s4F+m2M04PNnJyY+X1/QZq2jpEazWG8vgM7upNpLF8rNcRziJ1n3KIGxmkREIw9sPBn9SfSlQaBcZyTAaYEiWmnADA6/ZaQGeFqNjeXm1wkBAke9KXffu5f00Qok7rpbGpj/nGjbP439sw1Ruagjt4urJipL4b0ecpW5UDLRAnBLtK5CCQyott9UpSjL6HAjHYoB1zldWFVlCK7ZqlvyWmhtFKQorerwjNxDanypgSGQZQ8VOgKPlbaBADadBONgHEALON5M296reJSUkxNdYFXOXLMfMvWXJtixnhMtOUgYjxlKu6CbViCuSB1ZK9jSDEOGoGs7pUJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ad2aed-80cc-4ba5-7299-08dc2c1d65e1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 22:53:15.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVxGrbHA+8LLpULcFe16pbX+cV9fiuIDhbcKrKRoCCAaACAnXpUNsCacc9YafmDaiLUVL4Elw7KmxJ7L4VExrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_18,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=702 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120179
X-Proofpoint-ORIG-GUID: rj5vNhiGqhKnHe3lVzysbGADtAzFmmT2
X-Proofpoint-GUID: rj5vNhiGqhKnHe3lVzysbGADtAzFmmT2

* Lokesh Gidra <lokeshgidra@google.com> [240212 17:31]:
> I have also introduced a handler for finding dst_vma and preparing its
> anon_vma, which is used in lock_vma() and find_vmas_mm_locked().
> 
> Sounds good?
> 
> > I've also thought of how you can name the abstraction in the functions:
> > use a 'prepare() and complete()' to find/lock and unlock what you need.
> > Might be worth exploring?  If we fail to 'prepare()' then we don't need
> > to 'complete()', which means there won't be mismatched locking hanging
> > around.  Maybe it's too late to change to this sort of thing, but I
> > thought I'd mention it.
> >
> Nice suggestion! But after (fortunately) finding the function names
> that are self-explanatory, dropping them seems like going in the wrong
> direction. Please let me know if you think this is a missing piece. I
> am open to incorporating this.

This plan sounds good, thanks!

Regards,
Liam


