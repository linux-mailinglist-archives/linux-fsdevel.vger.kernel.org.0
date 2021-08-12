Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288883EAA18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhHLSTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 14:19:33 -0400
Received: from mail-sn1anam02on2078.outbound.protection.outlook.com ([40.107.96.78]:54525
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237823AbhHLST3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:19:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc3OXdKui25ckuds/5qnA9ZyfdpDOQkLoTbM/i4Qzek/yhvi6i/1JsJTlBx7K/ApdaXCB3sVEMEHDxmZu4f4KLTErVYNFgvnbSmYeaiCg4Fk9Kv2zGtJ00LG4MoqO8VmZWck2PqD17aQQO5f4U8Qkq0fYnAFR7l/FklRvIG7NOdLICvMimzn73pOZ6xeaNkXYZbZUzYk+A3RLLFYGw3KJfGdt6vjLEZnR8JvE7NfKidKRhkuop9Ixd0m+yYJX7JmRcCjP4gHc7zkQGdxHxHXe6pZ4Xa4nGnO4Ut9EosJ0QbVqnGXiy5DVzAVatN3GkBPQ9Qf7pbCBAwEpgVM8GePKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JWYeeyM7revPmQjm60r7erg/lrzCS7PXXvywT8khb8=;
 b=gnydB2dDF3xvRTb/SHLijFldbrF8Ii8CBa28dJBOyzU4Ui3XqtyV4XWGzPliIgfMemLZbQ5UzZh9qZycRLWu43g6zGGehrBppokKL9BXvGlU/RH+hxdNKhTptKUeyB8i2B2Y6c0m6jRnG2S7/sUyPHSAJlG+IVY/RyXBYvf6IEn4d1Qb07TUSGQuIbmdls5pol9hppnxrPOgooZnMm2VhqIEgq7n7oikAoJ6h92ucyyz9I3RqIry7xajrozjvEWBWeWG7SeG8hndp9jgxnD7MXnziWp5r3FEystFnumY36PscoUQ6PW3WiThSWWBO6KPqzA1uJobOzq6k/tOEIUVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JWYeeyM7revPmQjm60r7erg/lrzCS7PXXvywT8khb8=;
 b=WjpZylqRHcoKsQ5/uvv8se8QVSn5VaEfkQqyRcGdkH3BOW8fq8ORw/ZWqL7Yd6XmW2Nyd1rGIFaGmgtmc3V4FVE4hVJxQ1J7QR/FO1OPFZdCddiYxdBtkSOJ7eEHvcAlvFX6LCoo1pd/CWfjBi6xBksvoSdBN6mgsBRGIdt23rXV9Gn2HzH7pvqvd6/yaGB53z1WnrDjAhCzg/+R9NB3ItdFbxFX3q9s0zLXjcfGSQ9q/XN1oR3/odNJ98S+so1UbF4Iex6aMoId44qGyLylDRDB32MemuiBN2OMNdKNXquieLgQ68lY2d56ryctPFvdZkJ3fu7MLLqsLjzGB4nf1A==
Received: from MW4PR03CA0231.namprd03.prod.outlook.com (2603:10b6:303:b9::26)
 by CY4PR12MB1448.namprd12.prod.outlook.com (2603:10b6:910:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Thu, 12 Aug
 2021 18:19:02 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::9e) by MW4PR03CA0231.outlook.office365.com
 (2603:10b6:303:b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Thu, 12 Aug 2021 18:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Thu, 12 Aug 2021 18:19:02 +0000
Received: from [10.2.53.40] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Aug
 2021 18:19:01 +0000
Subject: Re: [PATCH v2 3/3] mm/gup: Remove try_get_page(), call
 try_get_compound_head() directly
To:     Christoph Hellwig <hch@lst.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20210811070542.3403116-1-jhubbard@nvidia.com>
 <20210811070542.3403116-4-jhubbard@nvidia.com> <20210812092204.GB4827@lst.de>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <5bf6d220-1126-97a6-c7cc-3c198612c5c2@nvidia.com>
Date:   Thu, 12 Aug 2021 11:19:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812092204.GB4827@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 301ff135-5351-4b57-abe9-08d95dbda9b3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1448:
X-Microsoft-Antispam-PRVS: <CY4PR12MB144890BF79C849A4D23B78F8A8F99@CY4PR12MB1448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxTaqPiP1T/OwxyqfodGSeGGDnMv44N7+UdA8EK2Mf5ksmVPRZ2k9GgKlphkFMqBvD6zUW4KlE/qLMNjcAdzFKbBsgRF1CTK+ShjPDeXoWOyEBumSfB203zzpqS9XaorWILRK4je6+AU/HL0N4dVgEBQE4EmDp6L8+NR5S0Nq0ML9/lM/2WCw0ZXQRqb94BCA2aVInCYyiz1FfKebJZygFEXw58b0pTmhsx3NXnu1ctA65eDo7l7FCbH0iWE2jDA9Xbko15Bfil36ywGIEPOyN/5qrPvKE94fl4IhbO29ZU6Si05D68jjcBvC5WU9TbaKzHM2jSKMNJ3GK4g6pokwgprobSB018ooiyS65Kz2yNEBezUVh8Efc/hYyR8xB8SYmBxpochxDkpKIczpo4TowDretGXEsbfHTc8Krm5keSf1BIVw/ar68Xfw4bWeFOpVHIcyTafBfCaGQUWHpt3ukrV9lu4fhm7QPPHSUsgaS0SGTNBSCRs9fnyVG+dnf0z7gyFr+a83T4VxbpL6UvpMnI1JqSKs2X0/kx2NGI/DxQgJWPVuxzJAuQ319ul46O+TGKCIOv+wNxwhxDmHRNjLy4tc+nJ+/hjyOVWmAEkdkv0by1B8zFtUgRXMAdId8BVDrlKa/MNLwwPFSqtoQEcsCJPSVuMqfTOa2wgi+Y5vQKBBGwliNGJUItPX9WTJiC1Hfml2/pGlWFkr9UeYNpTFjKmsHD2QuqRWjAGdWG3zgA=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(54906003)(2906002)(356005)(478600001)(5660300002)(31686004)(36756003)(8936002)(6916009)(36860700001)(316002)(7636003)(70586007)(70206006)(7416002)(8676002)(16576012)(36906005)(4326008)(82740400003)(4744005)(86362001)(426003)(2616005)(53546011)(26005)(336012)(47076005)(186003)(16526019)(82310400003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 18:19:02.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 301ff135-5351-4b57-abe9-08d95dbda9b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1448
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/12/21 2:22 AM, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 12:05:42AM -0700, John Hubbard wrote:
>> -		if (unlikely(!try_get_page(page)))
>> +		if (unlikely(try_get_compound_head(page, 1) == NULL))
> 
> Why not a simple ! instead of the == NULL?

I'll fix those up and post a v4.

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

Thanks for the reviews!


thanks,
-- 
John Hubbard
NVIDIA
