Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02673EACD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 23:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbhHLWAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 18:00:02 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:8032
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233038AbhHLWAC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 18:00:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3FjT92MBWFsq39xDLvXcfx8vYUFaBzDiUiZwdiAglbcCvvWJJEtgsq50BsNlBMfKtGckzKXzb+KDYLbJUg/h0rvcFf3G8K//rsElcC2yS7h8gQJrVywTOHU9VTafv/c2u0oaPN9mKubB1TBm2zTecZpKqJ1q5IurFsQf+HH0kOFlLiBtWqJI+jSF67kmGsN04pFyrqWehiJO4OLHKHcAm26FsiEIzy/fTJT6meRPZOqg9PlEm5Ajyx+1IOa2hKxiELe8BjHkKlVwqMrShjQbNt+9ATxqvYbMWM1TC3FI9rbPoONFCOwW1ArVsUIJrfjDA+atfMw2ciImOEsg4k4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0xxNGUGpNr4lI0ZcJKlHq1Xj5Bm4CcGn3hljN9NQXE=;
 b=UymS1BKWTsYk9Ly/mXSz7Bo3Nv+4kmmIYNbFq1h7DkxwXaYPG+vHpJhGOQmmZxjxMuk9WnENlY/SkeHTPn2nQfYWS6qmiAdTQuAK1LtOX8ZoildZ/gNBWRseUDbOrasdjhjN6m/EQwR6PpJweHK91mWP4hH4rOnbjafZt69KHCHLLWSYprMGW+4VpShj5q/cgCt484wnv9wnWd1J0TsuL2ip52s4H69chp2ko8FfNst9PKpeP3wnJ2EW9+TO0WU6aPw5fZBW1FmYb8WFYMfWAlOcZsHXX9IrO6TfpsB5iumq6u/mkuTWvzbClj6FCItF5gehgoHboqXtHxGXvzxCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0xxNGUGpNr4lI0ZcJKlHq1Xj5Bm4CcGn3hljN9NQXE=;
 b=X+kF/U6zLUsOa74WGTWDurA1Jon08CNJBQ8ufjsFZWt886y+WWD3FYr2hkKeQOoyPZbdqYFzlQDo33FEjZbTd+uC5wESWoGRoPAk3+9/1EOopUpuTDS6W02BwVo4vmZ+NtFBHsLRmoKSleq/rfBvKLgvmUx0jFjWbtwFHiXqTjI+vDpdWNGfJgIFlCaWC/BJvmqVGZ4fjURaY21aEBj8wbbe17ANLhX9bDSg7tMPYy02YVDQByOLMWgnCZVXLoj1z4GFrZ1h+5+xJXISkKgeZtT+QxUKXhnlMUk49sPn/8gKgT812TRYaKs/V7dQo25Dx1299oe6oJr3ddiqaUssUg==
Received: from MWHPR21CA0032.namprd21.prod.outlook.com (2603:10b6:300:129::18)
 by DM5PR12MB1738.namprd12.prod.outlook.com (2603:10b6:3:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Thu, 12 Aug
 2021 21:59:34 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::b3) by MWHPR21CA0032.outlook.office365.com
 (2603:10b6:300:129::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.4 via Frontend
 Transport; Thu, 12 Aug 2021 21:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 21:59:34 +0000
Received: from [10.2.93.240] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Aug
 2021 21:59:33 +0000
Subject: Re: [PATCH v2 2/3] mm/gup: small refactoring: simplify
 try_grab_page()
To:     Christoph Hellwig <hch@lst.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20210811070542.3403116-1-jhubbard@nvidia.com>
 <20210811070542.3403116-3-jhubbard@nvidia.com> <20210812092043.GA4827@lst.de>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <37231e72-c6ad-0509-c284-e83015807f43@nvidia.com>
Date:   Thu, 12 Aug 2021 14:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210812092043.GA4827@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc714b14-aff6-4db5-d71b-08d95ddc7870
X-MS-TrafficTypeDiagnostic: DM5PR12MB1738:
X-Microsoft-Antispam-PRVS: <DM5PR12MB173865015C6B239AF4667A50A8F99@DM5PR12MB1738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQOD0kgP/cz1uEXVsEvi9ItGRgxWpkWT8b7D9WVixuq3UFht7JhEGw1nuDWMVTmgcLQhW//ojDlEkdVZga2lVkxRxztLayLO8y4l8299beAdYMFPomfTjrELqho6zROKzdUesSADCLk0ljq5o7c9fpZq7vIeVV2DH3YCW0zmPTDXaTBD5Rm8E5vP6o31j6nsuMdzHuU7bBGN1QCJiyYDmkT/Nc8lnmQUv7ka/7DVWWqDT08eVWnCxbD3AiKjr6eE5pChfG/miNPWMEi8VMdfO6KmZ7s66INohRncrAVOahlLj/XmGoql1gtYWDSwaYDWp7uB2z/l28Utf3FU90+ezbw1jCb6MmUjh0WwwGrhlL78vlCSD37CGePPinixPXoxxCyz60h5WObvtN5FA8Fzatf/CPQ4mMg+QOQ6lzxPespuPFVh9nlO4sqHaPxld0vjq2VUbY8+/AErGu3Fs/068dDx7KU7v+lAXR+NPqT8VqBZC2AYrIajULjx1Q4CjwTd8LCJTQWg1qSm+9D/Y5acAdMyOArDaGg8uaqBUlv9iiBx9vX2zXpssZmJ8qumjaae7U04UGc8SkBXeWUDXaTVtsMcyrkobp86HDZcMHKI0mHrWJgJWbpbONhWNR2SUG1OEBYeUyWw8YSbil+ztl/GnIdD4/gThKaa2H+9LvWIniKHQ91eSfjX34oLxN8lMvI4phyePCw72oSaZCS6Az/vC3dywNTOsAHwHXOnhidAVP8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(16526019)(70586007)(26005)(426003)(2906002)(82310400003)(70206006)(31686004)(186003)(7416002)(336012)(7636003)(2616005)(31696002)(36756003)(86362001)(356005)(36860700001)(82740400003)(6916009)(478600001)(4326008)(558084003)(316002)(47076005)(36906005)(16576012)(5660300002)(8936002)(54906003)(53546011)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 21:59:34.3335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc714b14-aff6-4db5-d71b-08d95ddc7870
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1738
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/21 2:20 AM, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Note: the __maybe_unused on try_grab_compound_head should be dropped now
> that there is always a user.


Good point, fixed in v3.


thanks,
-- 
John Hubbard
NVIDIA
