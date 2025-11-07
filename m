Return-Path: <linux-fsdevel+bounces-67433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDA0C3FF76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 13:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683FE3B4090
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 12:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C689C2E7F2C;
	Fri,  7 Nov 2025 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qtXb9ZyM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rtcg2ajT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F6243954;
	Fri,  7 Nov 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519269; cv=fail; b=disTPVzcLjbaVXy821U4sswu+rwHJG3vlljWXiTgI6bsA0PiOGw7K6ClTrCnTEIxAtMLsSjXNLsaonGQ3Tl7Ltu8b98TTijyOoWOtbuTC6EahUrrpXOg4OOtw/kSP0aTmmAjo58Z0/iDKmXQdZxWUPX/XTn8Gwma3rvLlzclUiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519269; c=relaxed/simple;
	bh=q6ChFv4AyyOeKKZf4OC4n9bY+Jm6lUKbWZFT1244I5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=chKK4qnPwFoECvcPguf8vzq5rQzEY07zWVC3XqrId1sZFHyhoPay0Vrv7KKml9LpgaZYmr8DU2wYrHVGMhWk+nWy7K8FCS5ut0haO4YqF+TSZU/nLOkng88pKZC0+aQBm5XTrf/eadkZ3eO5Q8ipDg2k6mu91OaTiJa7QkWswqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qtXb9ZyM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rtcg2ajT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78uN6F011618;
	Fri, 7 Nov 2025 12:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=a8kJmo7nKPQ4Ry6rU/
	gW+rofld+HXaB+NfHlNttRGVc=; b=qtXb9ZyMDLCdcWmRKZulcxrbgeDczIbqNW
	Jm3S33CKnhY3B3s2imsZEEciuoEpL6gpms9YVxAVSlBwZwCqHtN+4yZ1PcdPH2xX
	IgVTF0tWgT3z4iSgyozOGuKyOF7X+inzLOzonbVTgS0EgVt5q0IMg+nj++hv4GQD
	dGIQImnQigXaqh8CpaGyYv0iFP0/gu6s5Au9Nk//fVJLt7zYjHPIRC/wSeX4p7Q2
	HqBJGP3MxjJtWiDyvSJ6sRmi44mussMCXzfiLi+GPamimCzzxJeiHn4/F00hjIbI
	hY57VcDqAurgNraYhy6VdhwTf9jFt/paIszTZeX1iBne1TT5OO8g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8ytw9sc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 12:40:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7BlP0t023110;
	Fri, 7 Nov 2025 12:40:45 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010003.outbound.protection.outlook.com [52.101.61.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nh91nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 12:40:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXA3IQQCXyAuiq0lzI4wV//jnr/Oqf/QY2yf4cleGuIOeKUUbynxxyEZ38Srk5FwndK+Q7G98nvW6SIuN46Ut30WelgA+K+kc4KL6W8+Tx0s8GTok8cG09qXArpySvrtEZWpLok4b7ClFy5oM99PcTFZx3GyG0qJGCbhRZ57EbeWm4NJhfkKtXeU29QFcGTjD07XIZUp6WEPppJNnHg4FpAo5vgucdDD/iNpaiV3M2tE8juDhpWQGb4vyy90czqfDU9zLgUUDMvDofLemHxsAqjQ5GsO5jz1XS1HwHi8gDCbZLXOSQkoPuMG3BASyGTPnuxDBFBys7N4tF/T+Aw/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8kJmo7nKPQ4Ry6rU/gW+rofld+HXaB+NfHlNttRGVc=;
 b=reTDI8RIgYAPpGUGY+oBgQeJktDjKDpp+52RKT1gtVJgf9klw1YYdJ1jLoX77HhkCWRDftyANo948v6MyARFcpo9MW/u7+w0zDi5kapho6sA+eF+lb7T8OYrMeSX+43T/kVhg9Z1jObMXRh7YtF8dt5JLHM+fOgLUejaPou7GFq1enX5ONLuevaxkebIxOjouZhQYB5+qfYpP0j5LqdYyNCGbmaBBfsclNCze2igf+Lo/uItWM27p/hnz+jc72Dv75UN9v3Fl/3ZhFdMxWU1VfcMTfeXxQCyAHy4VP/0Tlt3/6KWo0EebreMvVjaSNTP3AJSpXpmvCi9qMrxXrK4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8kJmo7nKPQ4Ry6rU/gW+rofld+HXaB+NfHlNttRGVc=;
 b=rtcg2ajTK2NKHe/l3ecI+VrMPSbKSQiv84H2cWSBdNSjE50W4AJnGmUhzkQjapP15twehVvBQKAWcrDG46CFqZ+yYMB4yj8fMh5tDXjdafvXQdv9DfRDAFvnil6T4lcQYG0p0aw2P3xPi55bltOgujELre3CK/TrBSLuV0SA2Q8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4308.namprd10.prod.outlook.com (2603:10b6:a03:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 12:40:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 12:40:41 +0000
Date: Fri, 7 Nov 2025 12:40:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2 1/5] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
Message-ID: <8f291b26-536a-41ce-8cff-3b0871e6930e@lucifer.local>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <fe38b1a43364f72d1ce7a6217e53a33c9c0bb0c5.1762422915.git.lorenzo.stoakes@oracle.com>
 <yja2mhwa4bzatbthjjq5rolqlkfgcbmppic3caaiwi6jc63rbc@cims6rqnotvj>
 <043dcbdb-e069-46e7-8f79-8fdaf354fb44@lucifer.local>
 <aQ24HAAxYLhIvV5U@google.com>
 <0f7186b3-16bd-44b7-a3fe-637af9d25dd3@lucifer.local>
 <aQ3iO40QYEM6Dxfs@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ3iO40QYEM6Dxfs@google.com>
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b3f3ca-877c-445d-056b-08de1dfadcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhAdlJle5yGEzeHSzGiwEGnjlkI/z59YT3vkS4/z/6g/p7hYBZL0MDC6rptw?=
 =?us-ascii?Q?lvcX7CvtFj5wCcW1KXadOasUFq3xggTzyXbsSAJCOOT2jdcVt8lbptUWXmqo?=
 =?us-ascii?Q?lCWmpnMEg788oMH7b6jEZHfETBcHZYb3UXO40/++cGDSsXTr7RTpoNX89qVY?=
 =?us-ascii?Q?bhKWAGgy9ByXLaNvg/n1lgdv4elnMN27QmipkH7GdAqNGD+6vvJvoQ4paaxO?=
 =?us-ascii?Q?lJ6Az5ea5Nf8oNPjiApPZFgOYYd5M86GQ35IAYRBLSaV8CkGNyxmK4jnKbWC?=
 =?us-ascii?Q?45F25cFCy1KFoMHHRIUEdG0hek35lsAPXuJrCMOc8GG+V5lRlf6qKBsdoNiO?=
 =?us-ascii?Q?ZwKigFwVI3wCK9cjdOYryG7eyFNik3H5IVuRE5fKi3Vmzfop4JO5oC0c2/eA?=
 =?us-ascii?Q?va70D2Dwt/Pg55QImD1sOuISP6+lNfvaVWL+gAzS1Wbfv3EjAug1qABdHqBQ?=
 =?us-ascii?Q?0XU+Db7C84T9ymsf5tXHv+bingroLOO09QEOpix3MIoH5vr+xrClkM74i5Ko?=
 =?us-ascii?Q?0nOLTlFdPsZquDubCylpwpF3drG/uJMQHgPD6LPForT/cKpq57qhAKIziwdR?=
 =?us-ascii?Q?c+JBDpEslGuDZXtgV4dlqp0I+5Jm6cisUIWFSLPpqbBxJ/hv4WlUDQNCycUz?=
 =?us-ascii?Q?7rJbTWu7NmWOxCdst9Kg0ZHMgtZC8RrJIxBJwwt78tSvJsbRdxGmktJAK5Bz?=
 =?us-ascii?Q?rZUtTyJsjMEDzz10zQnw3ig/bKcqYTkPRTYuK/+urvwwN+4suTL9sc+NQiHI?=
 =?us-ascii?Q?yFPjvXK2voUrOz5CqVII3ivNrZ4z9wzuIsJFX291C3mLuOwvF1a00dCZ/oWc?=
 =?us-ascii?Q?f33D06v/w5AHTq/Mpm/AYTr0CVhac4iWcLPH+OUgvrFtFgjsQEVBQNTp4hpC?=
 =?us-ascii?Q?fiBSMyqOVF0L/4SDZKKFQXMvN6T7rznRYOi2hYEposQcqv6vSfkaE8Bs/wwG?=
 =?us-ascii?Q?yDEa5pn8I2LJH5wF/qIZyPda/hexf+A8YwqPh7JEQDMOpovuWcmvyVcDHH01?=
 =?us-ascii?Q?faH6P3cRpaVg8Nfd2Nhvda4RT+H2e5n1ejHA5TCXVIdWqj6i+wGLoCBC12S1?=
 =?us-ascii?Q?sQIMWOe17pviNqvpASJJYr4SwEK8xU6c7N2PJ+0zxeQ2jUQ7O0UJ3GycOTVn?=
 =?us-ascii?Q?l4mUe9Gg+jiQrqFhrEW+dFyp8iLYnLZq75jDgQJvTDpEWioEZauo03vbBeLU?=
 =?us-ascii?Q?JpQgfz3gIJ8hwFy4DonquY3VWDGS14hfx0HVtIVS2kTIYyGVt31vFRPyPgBi?=
 =?us-ascii?Q?EmdzKqwInadA+Z1H9QTrtUxloJZu43AmM6jZXY5hx1gCs2QfV5xNzbVNeP6/?=
 =?us-ascii?Q?QQZY8ADf0Q2k5RgV1aCcD5ZO98rwJkVTiXC4ZiG0EwMcZXQKuhtnJ1jaw89b?=
 =?us-ascii?Q?vfpQZ8y2C/VELGwZxA0AxPYUiqsfjQjqaT7ghElDaBYfI+4JgK//0+tj6hNZ?=
 =?us-ascii?Q?92Vx1WPbiw4BAZIytN02F7OqTC5iI9Jr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iPEakMMLUfHOUczdRgvRM6ZxTqJNXNfq4Ujq8OpDy7Ij5QONZ3dkOZau5Sp2?=
 =?us-ascii?Q?BJFw9LxdQtfkxudH0bV8EQnUxhn06P37qLcAAz0xnswNCuEnJWAb0RPJu3Pj?=
 =?us-ascii?Q?3cEWvgSpCnvSjZfcXihL1g+1lpkvbh8finFKx/BdxcjlGOkR8gPNmTr4TcMG?=
 =?us-ascii?Q?ePNB7NXkHPrkiGrFRVtk2hqYrkrNZW8o8bkJSClyQbRHR7Re+krTITKjmG+R?=
 =?us-ascii?Q?O0wF3ND6S9EeueqimsAdeZE3Dte/t5AwBbfGdL3oU28o0EKY7Mhfvy96wdFW?=
 =?us-ascii?Q?jdq2WiA/medoD6PbAu7YNEoWhEZM+rgLuUyGbD+H8lKLhACu/CuTV9VOQMiB?=
 =?us-ascii?Q?tD50IjnHZuqSgnwhBf22CTTijL/IV3vOz8D1svUkH8SG+kfjXqcP2zhb5aNS?=
 =?us-ascii?Q?PoL75NCJ/zzl/yZ2w9LjhmHu4+n9n5NikIob8wf4UYWOkWt0ZS2dNbzQ2NTV?=
 =?us-ascii?Q?CpJfVorCDW2Zb6lRunWHzICvHRAXbCnAcCzH2ftoQwqtsFbKhqRtZprFIeaL?=
 =?us-ascii?Q?jee6X3bAX7RtanFs9FUEOUi15/5Sd/S9A54CtBQR9TcZhQzFZfKIaE8MHxfq?=
 =?us-ascii?Q?OkqYxNjAMVaCbBe4CPyemdsxs7+M78Fjvm0+cCXTkARQs/C161rKDPFlbMZc?=
 =?us-ascii?Q?8PkRF6LfN1/EoQMzKGy2ywkzwy7jl5QApwkmEwGbTmTbQbuvHSduarCqRsGS?=
 =?us-ascii?Q?Qdwyj66T3RYgzLHBKvKU+iiJjCag2YtUD8qEaZF0Lk51AcPHMmnMpfS9Ypj5?=
 =?us-ascii?Q?H/0ziPI2WODt+aW+tThtTKwLqtsnwWNvJ+8cP6Uq3LcwL6IlHzSq6HIBtWyT?=
 =?us-ascii?Q?wETJGC1NyioXiZimMnlEw4IV3MwzlRpYboHcIt/QD8ySN3GWZbr8IxIYwVyi?=
 =?us-ascii?Q?CWbeXtx/FAJhO/L5dLsuZ2k07129Nj1bGr3rk5Z90g+8qWClhW2HIeoxX0IU?=
 =?us-ascii?Q?GWwEUAMWIXlWVzXKD05l9G+WyzJEzT/QYVqaeIYisAYgGK2a8cv9UXqyWWx1?=
 =?us-ascii?Q?ThN0voFX71Ys6iYapZuRMkSFMWjAab9vf/swZNQpF3Gp7+6tLa6dGb+XCX4C?=
 =?us-ascii?Q?CSgVsnFGwPssSX+SGYDQt3FkQaavoWESY6TWZrdm8FEnUYx+wpn1XCYcZSl8?=
 =?us-ascii?Q?xqMeYVBNL+iVlAiiG4bbNJpR3tba8GOrm33hcHo8NtEc3ZI9tfQAXUvVVcK9?=
 =?us-ascii?Q?+lwppvmhduJm0cuEpnDufRVFC75KFn8Idzz6ArHIcnHs6jWO5KNBHHDdbs+w?=
 =?us-ascii?Q?ENDDtBBZWLFOH28Fe/Qgp7C2mN7Im0poakEHYDFVL/2JPcJ6KUsTdFguB1uE?=
 =?us-ascii?Q?nt6EfmfLQXIC7cPEIi0Rm+buZdwVQ0+RZSAPtOHedsa4o+eOnJFawWp0VYib?=
 =?us-ascii?Q?aGSBxC6bjjmEz2TeeXq9zlTPO2xYgdhowcniep/eAGR4YWvAudWfd5e2nFZN?=
 =?us-ascii?Q?CFCXWMw3JuszRk42Jw+kxlG/2pJ2u+/BioQ61nsA/BaLY/3Cm2UyP9WsexXi?=
 =?us-ascii?Q?xcVnjZqVX6WC/tjUh4Hz4OttkQXAodN7zC4KtMj5IIIMe35onxMy1TGNWiBD?=
 =?us-ascii?Q?yXxD3FA7U6rsw6uTXiS9K1BrN84fc8w50OG2wXoJEiUSWtnJ2+wqrnbnqjlM?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pOb3eJL06b8pibN14IFQLRTWVk4+vwM1WZ7a1XKtPLqFbwffN0DGLeMYARx5AsANrO5qe8g00qQm3VGSUIKem8rOjgPjCTZI17D/1Xarlo+9F6CPnKH5lhLgiiNJEOlk5LlW5+5rYp9UMe5LPA3PmKZDo+Gwb/wF50lVfOPGzhauYTysu9weP5OVr4WH8cOmMB135AIhkLwu5jdokPCwHnid8dKPw4y1gYvptUffCqd0JPnIhE8xtADo6TZDZQPbbCXQ6baGd09opUrdAJuqg581WIxk3AsrLxFJiu5gAjxY/Qj8Sv9Dweb5bEMaGLj+jTbCe+kHmbB60tjYPkTcDOTBVas6mS4mdBS3b5JFO90lmbirzN1Fok8cvWySMzzPeVahsklHSqXfp2VEmVUkc3NyeiTetmELmu+0r5SHQHPgLL9lHuItmCloBFOkOTw7/KKnFL3jhI8NwMns6ECWXt1AT8IvAdmjLU3Qs2tSE4gjZwTCGVyD6dVhXjVVeLN6HpAMAlKyxmFty02RYaIVL8v+suHdRnQA9EMZuyPmaCQYDA6flS4AaEaEITFh5Ncof2VmjBcolHPkvAp7ILUaT0MXKGyVH8VSWkOe3hVHZoA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b3f3ca-877c-445d-056b-08de1dfadcb1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 12:40:41.5453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onT0PgeIzvXmAhSyufFvkQUyTBN+0J2/MWivL3XAoJyzK5KlX4a7TUq7XKej0D6yRD6M+eIFB8M8P3qc09ptrEMV8Xe+hMaoZmLsBmDPbTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=973 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511070103
X-Authority-Analysis: v=2.4 cv=L/wQguT8 c=1 sm=1 tr=0 ts=690de8cd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=ioD9YK-olDrjc_HnVRAA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12100
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzOCBTYWx0ZWRfXz1Q+HDVVuQcP
 kY43K/tM+NK12d+aBQr4qRhCeL6iCUIt5eq/3s+rHqusiGqurtAFKhOTYDrlAWPNAtK9KjnDHwK
 KnMF2V4RyCSd1O6hdzeTKceiVIRlJToREeuzyIrxoGWEvPDFGoqMiQGc+3cRj97LF65xEfTKo//
 Hw2V+aJJzbkyAhIqgOGrLlQf0Evdv1J8LPPi8KhX6maemoF6ghvM8DIGXfQYCWKhcqGCaq8kcZ+
 QoRMGPfU66X+jwhFYIClsPpoIlljPg3WwHn5tVcE5q59ZYnM+RBzcB5I7pdF6fjJnxPUWd1lcgC
 tVl3Ll+JmmN67/ve2kLbY/2aI2npSD+pdX6g3Engj72oFvUFX+DAv6k7nEpoCnSTeZsgsHIzurO
 SQnSSjnf6MKU/GtvidrTkGkwd5P6tfqSb8U3nnYXGqLFVqhcpSs=
X-Proofpoint-ORIG-GUID: ncrqVOOd5T0EaOHli8tCkE_0lWeGKOFn
X-Proofpoint-GUID: ncrqVOOd5T0EaOHli8tCkE_0lWeGKOFn

On Fri, Nov 07, 2025 at 12:12:43PM +0000, Alice Ryhl wrote:
> On Fri, Nov 07, 2025 at 09:44:22AM +0000, Lorenzo Stoakes wrote:
> > On Fri, Nov 07, 2025 at 09:13:00AM +0000, Alice Ryhl wrote:
> > > On Thu, Nov 06, 2025 at 02:54:33PM +0000, Lorenzo Stoakes wrote:
> > > > +cc Alice for rust stuff
> > > >
> > > > On Thu, Nov 06, 2025 at 02:27:56PM +0000, Pedro Falcato wrote:
> > > > > On Thu, Nov 06, 2025 at 10:46:12AM +0000, Lorenzo Stoakes wrote:
> > > > > >  /*
> > > > > >   * vm_flags in vm_area_struct, see mm_types.h.
> > > > > >   * When changing, update also include/trace/events/mmflags.h
> > > > > > @@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
> > > > > >  #define VM_UFFD_MISSING	0
> > > > > >  #endif /* CONFIG_MMU */
> > > > > >  #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> > > > > > +#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
> > > > >
> > > > > Don't we also need an adjustment on the rust side for this BIT()? Like we
> > > > > for f04aad36a07c ("mm/ksm: fix flag-dropping behavior in ksm_madvise").
> > > >
> > > > That's a bit unhelpful if rust can't cope with extremely basic assignments like
> > > > that and we just have to know to add helpers :/
> > > >
> > > > We do BIT() stuff for e.g. VM_HIGH_ARCH_n, VM_UFFD_MINOR_BIT,
> > > > VM_ALLOW_ANY_UNCACHED_BIT, VM_DROPPABLE_BIT and VM_SEALED_BIT too and no such
> > > > helpers there, So not sure if this is required?
> > > >
> > > > Alice - why is it these 'non-trivial' defines were fine but VM_MERGEABLE was
> > > > problematic? That seems strange.
> > > >
> > > > I see [0], so let me build rust here and see if it moans, if it moans I'll add
> > > > it.
> > > >
> > > > [0]:https://lore.kernel.org/oe-kbuild-all/CANiq72kOhRdGtQe2UVYmDLdbw6VNkiMtdFzkQizsfQV0gLY1Hg@mail.gmail.com/
> > >
> > > When you use #define to declare a constant whose right-hand-side
> > > contains a function-like macro such as BIT(), bindgen does not define a
> > > Rust version of that constant. However, VM_MAYBE_GUARD is not referenced
> > > in Rust anywhere, so that isn't a problem.
> > >
> > > It was a problem with VM_MERGEABLE because rust/kernel/mm/virt.rs
> > > references it.
> > >
> > > Note that it's only the combination of #define and function-like macro
> > > that triggers this condition. If the constant is defined using another
> > > mechanism such as enum {}, then bindgen will generate the constant no
> > > matter how complex the right-hand-side is. The problem is that bindgen
> > > can't tell whether a #define is just a constant or not.
> >
> > Thanks, I guess we can update as we go as rust needs. Or I can do a big update
> > as part of my VMA flag series respin?
>
> Whenever you think is a good time works for me.
>
> I think it would be nice to move those constants so they use enum {}
> instead of #define at some point.

Yeah I will do as part of my VMA series :) which actually is a neater solution
to this in general (and can drop the existing binding helpers then actually).

>
> Alice

Thanks, Lorenzo

