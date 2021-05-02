Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09437096B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 02:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEBAnR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 May 2021 20:43:17 -0400
Received: from mail-eopbgr750087.outbound.protection.outlook.com ([40.107.75.87]:31973
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231266AbhEBAnP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 May 2021 20:43:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me2RhEX1HfUJEcgMVwnMd5Fsdgi9ByScJkqsFakMKm5+6d6lXGDP41GJaU1kVmDd2Y/onOVQWxr5QSN3p7tyGb7Dh4sRRVlvZcwjM84zmQaltklk3O2crLiEQ0ie6C55lfDsyO9ecGcCpiaPFzs7Po8OVz6JDbE+kZeZno5xz/47R7U3q3IU0xkRzcf0XTOs3qzyaO1S/bOwpOi6GbvkdD/3mt9CZ82iIC1f/cQQj4XuUyt8BV8kN2QIiblYwd1q+3ooFUWiEzC9D+sb8rAs+uOHgGhivj7/AtfoiJrCIYGsXKw7u7txu9qg1klt+1KkYQgCGtSHSK4avIjy7p5SWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyaQ571Edu9JSOS1Oxh9rVFjkkXUbUmpl8/FBQmJi9Q=;
 b=l4uFOp9lSJdd8nHTGVJHDASqmcKjeBSYdw7CFbvx7U8ai2DMVj9TkRqQKRAjSl1bNn2+/1uwm94o5LAh2X7B+LhEAkpAEymHVJSI4hBTCrvDv+ZPIX1R/XEnnSK0WWwmGmSCkq0DX/c6o2MVb/kx+ArCk3Io1VeeaMDL3eOQBd4lxIB/OpoHVPIuV3fPQ0xYpkFKd9Xf+aDHm1u/iGBCiWenBrVrCvZ85I0ix9D7Nwjvhkvw/pRkd6XhlcwVlGk6DWBvaC1ZYkY1OCH/g89XVsE0t1mAavIr1aRsuxUvs6He1c6JjZZP/b5Mqs9ml3IQsW19FDtqh3ucrgOk64auSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyaQ571Edu9JSOS1Oxh9rVFjkkXUbUmpl8/FBQmJi9Q=;
 b=OcaD7D0LXvqccSPYAjiCa0z4QTvKYD+6pj0sc/pSPo3WXToce60iJnHCDzfO8/jQFq3fOleiZbMonfZJRehKgpXtsOqrCMYPZCwLRJuCqKkDNrF+Sntxv53+VBCcWUPK57rSr9LPUIHpJjb+fp5zAOJAHwvBgVJrwhhycoXe1o5FibLshpmjf3/HH4hbSR8I2fPxEW9tTupPUaYF5EttZt6RbuSCVE8rd+B1HqHvrcbdU4cEnIj7VcEORbqHzJaK5pgmQ+apOWelXxi3UA+EfvSRo6RLddaAyf54mcneJ1NDf8cxGk1YSkfL/yfL+9u26N+IshLruLz+Jtyvfat2XQ==
Received: from MW2PR2101CA0035.namprd21.prod.outlook.com (2603:10b6:302:1::48)
 by MWHPR12MB1454.namprd12.prod.outlook.com (2603:10b6:301:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Sun, 2 May
 2021 00:42:22 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::39) by MW2PR2101CA0035.outlook.office365.com
 (2603:10b6:302:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.1 via Frontend
 Transport; Sun, 2 May 2021 00:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 00:42:22 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 00:42:21 +0000
Subject: Re: [PATCH v8.1 00/31] Memory Folios
To:     Matthew Wilcox <willy@infradead.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Hugh Dickins <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210430180740.2707166-1-willy@infradead.org>
 <alpine.LSU.2.11.2104301141320.16885@eggly.anvils>
 <1619832406.8taoh84cay.astroid@bobo.none>
 <df291e74-383c-cdaf-c4c4-b5ccde3df153@nvidia.com>
 <20210502001705.GW1847222@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f8c968d9-e66a-3588-3811-3efe704650ae@nvidia.com>
Date:   Sat, 1 May 2021 17:42:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210502001705.GW1847222@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 265161e6-4317-4dec-71ab-08d90d032627
X-MS-TrafficTypeDiagnostic: MWHPR12MB1454:
X-Microsoft-Antispam-PRVS: <MWHPR12MB145491060962254C014EBCDEA85C9@MWHPR12MB1454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APNfGXqGSypFdqab7jD0RdloOkUcxHKz6sE0Qqvtewyb1ib5AfQXFwCoVDpV+JqbgptDrqyFDkgXL6sMZqmc3Q+MRqF+3RZdurYpvafw5dyIlZzaGipBxthovI9X5PNkh6Wx/JeEL7jZFJKHE/GHlMQKXwy0rzgMW6KavclwHJnM7y85FBpPuUt6H10Gs5XhJ55cVw9aIZpk+ip21+CMZbjih09Ea8A35c6i+1VRj8p3q22+g3LjxdOdr3TuVFvi6h2u6SGSnCytSRZElINGlDj4ODjh/bsB0rtmuJZ/NbZz4eVSkf0dH+3WggjORIu4xwzgaBXqBzhijRojGlpz0+BydJ0tajuEZLRvQjo9worPi1qkdD6c32UJkI/NVk9qtR/ULFPhzJj4YN0uIUMQcQstxlrd4sK77ImYbLBDrW/GHzmK4wDNCVWaoxwMn/hOeoSbmefqetZGrCcfmZi85CnEvq3LIprqWx60Wofwh4y3IZb6OcxW3tFsIwegDEdu8hkfj6YR39z1SJ0m3/D7dv5BgSVjp0n31wM2bg/W7Q+A8PxuTe6fhCBqpt96JCYaHyDYbK+yUDI06uvZvQlqGlxmyc0shXLzosg3Znqs9rYDmGMDs+0ZFj40wnxV52LaVUOvcg5ELQKZxTR65lgrWyNoCqn7Ik5dZA36Yq6zf/AbVFtnthtcQeEQa1PM4bdo
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(54906003)(5660300002)(26005)(70586007)(478600001)(86362001)(36860700001)(47076005)(186003)(82310400003)(8936002)(316002)(31696002)(4326008)(6916009)(36906005)(2906002)(356005)(16526019)(31686004)(2616005)(7636003)(53546011)(8676002)(82740400003)(336012)(426003)(70206006)(83380400001)(16576012)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 00:42:22.4808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 265161e6-4317-4dec-71ab-08d90d032627
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/21 5:17 PM, Matthew Wilcox wrote:
...
>> In addition to pointing out that the name was a page flag, the weird
>> camel case also meant, "if you try to search for this symbol, you will
>> be defeated", because the darn thing is constructed via macro
>> concatenation.
> 
> I've always hated that, FWIW.  And you can't add kernel-doc for them
> because kernel-doc doesn't understand cpp.  So my current plan (quoting
> my other email):
> 
> folio_dirty() -- defined in page-flags.h
> would have kernel-doc, would be greppable
> 
> folio_test_set_dirty_flag()
> folio_test_clear_dirty_flag()
> __folio_clear_dirty_flag()
> __folio_set_dirty_flag()
> folio_clear_dirty_flag()
> folio_set_dirty_flag() -- generated in filemap.h under #ifndef MODULE
> would not have kernel-doc, would not be greppable, would only be used
> in core vfs and core mm.
> 
> folio_mark_dirty() -- declared in mm.h (this is rare; turns out all kinds of
> 			crap wants to mark pages as being dirty)
> folio_clear_dirty_for_io() -- declared in filemap.h
> already have kernel-doc, are greppable, used by filesystems and sometimes
> other random code.

Yes, the page dirty stuff is definitely not simple, so it's very good to
move away from the auto-generated names there. Looks like you are down to
just a couple of generated names now, if I'm reading this correctly.

> 
>> Except that over time, it turned out to be not quite that simple, and
>> people started adding functionality. So now it's "cannot find it, and
>> it's also got little goodies hiding in there--maybe!".
> 
> I also don't like that.  With what I'm thinking, there are no special
> cases hidden in the autogenerated names.  Special things like the current

Yes, that's a good guideline: no special cases in the auto-generated function
names. Because, either it is a simple, standard auto-generated thing, or
it is something that one needs to read, in order to see exactly what it does.


> SetPageUptodate would be in folio_mark_uptodate() and filesystems couldn't
> even call folio_set_uptodate().
> 
>> Given all that, I'd argue for either:
>>      b) changing a bunch of the items to actual written-out names. What's
>>         the harm? We'd end up with a longer file, but one could grep or
>>         cscope for the names.
> 
> I hope the above makes you happy -- everything a filesystem author needs
> gets kernel-doc.  People working inside the VM/VFS still get exposed

If "kernel-doc" is effectively a proxy for "file names are directly visible
in the source code, then I'm a lot happier than I was, yes. :)

> to undocumented folio_test_set_foo_flag(), but it's all regular and
> autogenerated.
> 

Sounds pretty good.


thanks,
-- 
John Hubbard
NVIDIA
