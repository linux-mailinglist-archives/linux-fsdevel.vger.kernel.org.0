Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499F3366EC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbhDUPIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 11:08:02 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:7844
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243835AbhDUPIB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hodxI244DlnMlsd4U7em2E++AiS1m5luIMEOIhwG5G3yolHZZtucz9uQsDHVP8A/36AB4soPVuud29QDAAzzfVIw3GyyaTKZxEHhexKusp22nvl1RsNg8cH8E4iGQpEHshvXDaNg0qd61blzxUBB19lGFzAZBG1oUUbeJYJ17RoONA9HHetrQxAG3zE4v2/y3Hv1sKPHy+cm4FpzbQofE7Emoj5k4Uhwpgyz/nK+YhWe5nyAz1emiwfhzg0fz6kCj3PRG7cj1tjDvUKfT1yeh7f9GVccaf2DEj8BRqltxhapJjH1d43m8q3R3ydSjScJqxNYHoI5xY5Cji6WMJosWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hz6XlcExdhxkeP7H5H8MIczXGLVYlD+EsooV8ep78o=;
 b=eeYhHVsgU+bG1hn4SwPDoTtS8xJ3vZubaljUxum792+0CTqoS1k1kkyF8bxX6nTNr6zioxh34UfA4UxlNmOM8QCXer9csIA+Z8cWNkMZld9sR7nHjIB8Aljg9eNn5OLrAZC4ULn9Vha4fiB65TJ3gMwlJr/Op4CdxnmUs46DrC26LDqATimykoEGjl27rP+U3ZRF90+nZdSmfTBCt8sE31v1U/ry0AeA5+Cye504g15gPytn7v+9GXxNkSE84hEA9BnGdc6RL56iw9jyeshdeC4XzJD+EC2ezbAyLLjxRg0uAvRybIDFPUq92L5/xZHhEgX+1BpUjHVUlyLRRkG1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hz6XlcExdhxkeP7H5H8MIczXGLVYlD+EsooV8ep78o=;
 b=QvibK0bQIlXEToEuSGxbc10I80vo/GX+weKlGanL+TbQDObvT6PXFjKAjnztmONGyzt8BnAR4r4KQ1bTQ+yyaJiN3QqjSa6USlqpnyaMrX2cpuE5x2In7aaQRwZ72JVG8Mgas5cnh+mbXLFZLHIKA5hrgFMlM6M6iXcU3xk7WXMh2DpKpCCB4dZWSqcZvANNjlUwZQbBW9co7o0u+sDdvH8Hx68ZDfjIp6s4h1QJ1mfVE5bJhJROh9nkHsROMyA0nKGSRlk5ubrY5fUBu+0FslGKsgsGBKXyQCYnVnLEesAGUd+AN6LMr7lYNomOQoyfX1XyYw2lame3SJ8rXS26zw==
Received: from MWHPR20CA0048.namprd20.prod.outlook.com (2603:10b6:300:ed::34)
 by MWHPR12MB1519.namprd12.prod.outlook.com (2603:10b6:301:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 15:07:25 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ed:cafe::1e) by MWHPR20CA0048.outlook.office365.com
 (2603:10b6:300:ed::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Wed, 21 Apr 2021 15:07:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 15:07:25 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Apr
 2021 15:07:15 +0000
Subject: Re: [PATCH v4 05/10] signal: Introduce TRAP_PERF si_code and si_perf
 to siginfo
To:     Marco Elver <elver@google.com>, <peterz@infradead.org>,
        <alexander.shishkin@linux.intel.com>, <acme@kernel.org>,
        <mingo@redhat.com>, <jolsa@redhat.com>, <mark.rutland@arm.com>,
        <namhyung@kernel.org>, <tglx@linutronix.de>
CC:     <glider@google.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
        <christian@brauner.io>, <dvyukov@google.com>, <jannh@google.com>,
        <axboe@kernel.dk>, <mascasa@google.com>, <pcc@google.com>,
        <irogers@google.com>, <oleg@redhat.com>,
        <kasan-dev@googlegroups.com>, <linux-arch@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <linux-kselftest@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20210408103605.1676875-1-elver@google.com>
 <20210408103605.1676875-6-elver@google.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <81254854-aa22-fab1-fc6f-22716b7c2732@nvidia.com>
Date:   Wed, 21 Apr 2021 16:07:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210408103605.1676875-6-elver@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec883513-a740-4be9-fa1c-08d904d72c58
X-MS-TrafficTypeDiagnostic: MWHPR12MB1519:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1519E77813E2DDEDC4D904C5D9479@MWHPR12MB1519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoEHylcQurSelIXMAse60Pl6Vp6bWaXID/qD8iT4o2P7RDDj09dep7ybG0PGNTIPZtrO9bL8NPbghZ0enkUWyMBZHN91/+9n3JH8RjMdG0FpCQpYFunme/rAmMpWYWbpFgSVoLlp38AdziHzW+l++RuDY6RB+1NZNDrETm9xjiQskn+FvWbBj8tGw+awC08bZivrPCGC+N4yeGJ0nRtHW/jK7VZEd96vE1vusNKT2fFsXrIAvJ5+0hgJzCt0s3ethMw3JY+W2fpjSfxvUVI+XaNFFVZDHe/AgqpzSx/ujjyxX/hlP63lBz5WH84Y7nSKUF0hs0gksFl/oK/JeQjbNcPz4L97lbwW0md54jS6PlF1dc6X9gWV37D5ZBiS4RgxK4w4M05sU5b7Ve7RHZJeZHBUPvhHkmIAycLfi1SgP/yQ1kpZrDowPsp1LLvwso8WrtKUV29Z9oqHLO7JxPgKj5QoTeTDn8uDOdSLg3K+WSFpuul4IJcOPqfOEO2NLp6sR4jA50jUqBjNH8Zxf4rmb1BfuK9k7bzCnZCYm6JrX0qniphrEWqL2Jx8x2P307T3VACyCC7uL7hB2PIvqZ5G1OBZS4Iwykgb5GmrN8QtBtfXFC8J8oFbjpD3ZRqB7I/9wvT/Uqb9mnWRd+KMA/RWz0FsB6iAcEGpucyOox29HCw9x+jUK8+bKTotOMsG5PpWmaPK07XaTUFrDE7s6zKwqg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(36840700001)(5660300002)(53546011)(4326008)(316002)(36860700001)(82740400003)(4744005)(82310400003)(47076005)(86362001)(2616005)(7636003)(31696002)(478600001)(2906002)(70206006)(83380400001)(7416002)(8676002)(36756003)(356005)(8936002)(31686004)(70586007)(16526019)(426003)(26005)(16576012)(36906005)(110136005)(186003)(336012)(54906003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 15:07:25.7014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec883513-a740-4be9-fa1c-08d904d72c58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1519
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 08/04/2021 11:36, Marco Elver wrote:
> Introduces the TRAP_PERF si_code, and associated siginfo_t field
> si_perf. These will be used by the perf event subsystem to send signals
> (if requested) to the task where an event occurred.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
> Signed-off-by: Marco Elver <elver@google.com>


Since next-20210420 I have noticed a boot regression on all 32-bit Tegra
that we are testing. Bisect is pointing to this commit and reverting
this patch and patch 6/10 does resolve the issue.

Interestingly there is no apparent crash, but these systems just appear
to hang silently after mounting the rootfs. If anyone has any thoughts
let me know!

Thanks
Jon

-- 
nvpublic
