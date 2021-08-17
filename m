Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028193EEF2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbhHQPar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 11:30:47 -0400
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:54112
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232675AbhHQPaq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:30:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8p0/s1v66UCU8cRIvd1PLOMTFgVmheXEBzNV7tUXHzyAXOn23a85CeUo0SP9vvABPbjMHuEGc88nRKLYXwOX4WiF/6ZT5pHpmdOLGEtfSfav9cYqbAXspgwRXp2qVSZ768FRzdNuYuQfPUEPD+wenuK8HwR3KnOgzkTwthxMLn60NWjNOf6OQZ6JnpzcNLyFHvbPcsQene17UXpZOw8M2nmIYvCUYO8XFUzC3Fos/xq+9iqwz8b/7O4t6Z78Qhx1ojRYHR0zwG3bgmft9Eb5jR53pyTJ8q2k5qBciILdwtdBI4yCdSnK54EFu72vqfbfv1t2BJzt4XNNr0uF3qSxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A66rRV3c7W0mgNwkPHoKIUOpI9iw2GqGRRXgd8YBe7g=;
 b=ExcmHKOn4vBGyLhhXIPsRuJwgHSMgtCxXG8u6W4pzx/02FwoxGVNHEFxLdj7DUf1Mj8Zfr1CpSLk3oeN0DtaQRzN9IL8vMuCqwxI0sV0Oi4rBYUzRm0/53++nj/pm0rfp2p/FHBUDr13WOQ19cFXCxMGgxdhMfk/QLTxh6z25Mj4S0JAginZLSdTtF0PfLR2AuYXfxSHRhA4kdGa89Zzud5TVZwu2t0r/19F5PtAlLRT9MzaODEYTNAdp1qG2s22GdbhwGCSrlyIVHVE6Ekk6qqxDT5SoPp9eb1lvvD38tOEVPZn/nzjpGU8XcDGUQeEoLC3o5+Bj1pR4JAAC1XQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A66rRV3c7W0mgNwkPHoKIUOpI9iw2GqGRRXgd8YBe7g=;
 b=kVjY4i4nvtXGqBiMEHMg4PmEfi0qyN4/zMiUWaJWA/aFLBbhBYcGYOqX5RIm5LOCaJ3gPH7IK/S41bsJahUp/lL2bY4aCtU6iEPj8zFsTqrux61E1VWMmNyAJXh4bHHYHP4qoyqPemdxPCN2u5Ne5CMbZLGPu9CrCUMZzjSKFy0=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Tue, 17 Aug
 2021 15:30:12 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:30:11 +0000
Subject: Re: [PATCH v2 09/12] mm: Remove the now unused mem_encrypt_active()
 function
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <83e4a62108eec470ac0b3f2510b982794d2b7989.1628873970.git.thomas.lendacky@amd.com>
 <YRuN6QhdIQtlluUh@zn.tnic> <YRuOVOdxOZm0S86j@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <6531f108-7afa-360d-fb2b-02a0dafa0a4c@amd.com>
Date:   Tue, 17 Aug 2021 10:30:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YRuOVOdxOZm0S86j@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0146.namprd11.prod.outlook.com
 (2603:10b6:806:131::31) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SA0PR11CA0146.namprd11.prod.outlook.com (2603:10b6:806:131::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Tue, 17 Aug 2021 15:30:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2a7d1be-5f3a-4003-ccf6-08d96193e6ea
X-MS-TrafficTypeDiagnostic: DM4PR12MB5104:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5104599F6732CA17434C0255ECFE9@DM4PR12MB5104.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +hkfPEdX0PljAjCQNrcSjFSlWaa31w7KCtq5qjS0781UV8+QKDe06H7UinW151bFGyj1ReY1Yfbe+EVSdFj2LUNZlFW0x3ck7i5y2QiBhd9bzAOyGDv1MfHPOC8HPN3Gu/Tr0bLKIdw2SHQTQzpAXCGp7K0I9IF/xEefUJVgULmRBMr6IIqyShNR3PThHVrbxNFgYZ1ekL0UU3df1Rqy8RiliSAWD8pY22hKKpETvniuOHQNkyl+uV1vJ3hdar6MOmmytRKi+nLI7RDO3dvPRncWKnvJ+ZFWXALTcpYezULD/5+rJvAo12Ed64xzg15uqtejE6Z9RkgbGOk7TuMllSvyOEsLpiUFI5O2Ms8NAYm9e2SGPSZTRZSw+XrpPGGU3I2hgWgWadsrT1l0hEiVnAAcQIhUob6m47HKWSm6nUcNqa6UlyUZiymeIrw+m791/RpZbdXT3qp6uLOhJaE76GfqlNJy82A7LWu+Gty1zWahnx6rUs8vrVi/lfSoaVVZtNMpj5kMTDz/nzMhEKKAZEM0zDuvUbJJQ2UkROcq4BhWuztYdttSNwSSd40Jsvh4AWhcxssDT/fByv/rd3oX+AR/jSB4p3FMGOhwht/bzO5kbDTO7d1L2x3EmYqoLZyhvaElQsonPBXiEnlLp0iICa/vUrEjJre2Le2PCnLFMimSK8xZfw+Yd7WEK3Mvdob2d0gtIPt5IXzVI6RNxidpHEyMiZIgAwJg4ZR7HUtFVdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(5660300002)(66556008)(36756003)(8676002)(2616005)(86362001)(31686004)(26005)(4326008)(38100700002)(8936002)(66476007)(2906002)(7416002)(16576012)(54906003)(31696002)(956004)(316002)(508600001)(6486002)(4744005)(53546011)(6916009)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkl6cjBqOXkybWVLNXYyRmdYYVFTaHNBczlKOWxtbUZkV1RrZW56azNaUEp1?=
 =?utf-8?B?ZW9IWlFhSGo1K0JoVTVRcVM5Ymlac1NOd0ZPdVN2N2I1dnU4L20yVk43RXFO?=
 =?utf-8?B?VFdjbGtzN01zTjRGRCtlejBQQXZyMHBaL0RlT2krZ0ZVOFkwRXZBb0JXSmVM?=
 =?utf-8?B?VVpBd2x5M3IwQkY3eHRrMVVtTWk4MjhRY1FZWWZERVY1U1Q4MFdCNExWazk4?=
 =?utf-8?B?L05DKzV2UUJRTFlUbDUzRS9qMWtOVFlxSXR0aGVxSWdFYklDQk5LWGd6b2po?=
 =?utf-8?B?WUhGTUZ1Mjc1cm1xL3FlUlB6UUZ3b1ZYK3lESXY1Z0ZhUFF3dXErc0lOTy94?=
 =?utf-8?B?MkdJd0N3eDMweThOR2UrK1pTTU5mUW5vYnZHbUFmNGo1dkRrVk5OOGJLbE03?=
 =?utf-8?B?WEJrcTJGN25XdFFCdlhWQmtPQ3NwcGN2ZXkweW42b1pyNWc2N1o2OFpteFFF?=
 =?utf-8?B?VS9Pbnh4bDlsdEE4YmorY05hQXlIOUFBV0o5dGJycC8xNmMzdmdhMkowNWFT?=
 =?utf-8?B?Zlg5ek03S3BrRHZUakdSZVFib0xESSt0b3RXcTd6MnNIVGpTQzZPcUxYWWhv?=
 =?utf-8?B?YkErbUVucUJDaCs3WVF3ek1GMk0yMVJxcmxwakEyQzNHTllwcm1hT3g5d3J6?=
 =?utf-8?B?cHZsVHBRaldCNGN1SlpYQjl5dlVvZlhmRXhYeksvdFhvUU1saExsdTFHbmVX?=
 =?utf-8?B?SnJBNmJ4ZXpZOVhSaGwxN0I4MlJvSHU0QzV6SlZuaFZmNkJxSFRnSk9PbGIz?=
 =?utf-8?B?RTdnVHBVUnJyRHExRzYyV2kwdlFPckJXM2RsbDNQcEptSThPQjBHSzZuanVW?=
 =?utf-8?B?VEdxVWRJVWZZb1pXODdoSy9VckczWk56N3JvQlpsT2QvYnJKdTU3M3h3RVlF?=
 =?utf-8?B?d3RGOXRmcG1nQldlSks3MEFPVGlKQWp5NktsTDBXTTQwaUJ4cUJydTlYQ0pl?=
 =?utf-8?B?N29jWHk5bXdVWEsxZE9PQktzQzkybXVCWGw1aWs3czRMSThpU0tuREtHemNO?=
 =?utf-8?B?bmF5MVA3eVZtUkRMUmhUS2ppMk5RL1NHZDVxRzRET0N5RU83anZxRStHZ2Jp?=
 =?utf-8?B?TkVoTDBwT2dnK1VIa1pOTXJ6VGw0bS9wWGpSaEQ3NElreUxqVEZtQmM4cjhE?=
 =?utf-8?B?V3lFUkJXT2NVSzVQZFkvRENyaXdBcEpDMEVocUFQS3haQmRzMStHTlJtQVVN?=
 =?utf-8?B?T294VXVCV0dzZW81MmlFM0ZBa3k1R05TNXBOTERYcG9FRzcyZktmck5XVkYz?=
 =?utf-8?B?b241N3B0cFprN0lyY0xqeExLcDFtUW9QOTlZOHlBc24zcjFZU0xqUkt2Tllt?=
 =?utf-8?B?aXY2SzdJbE8yVXkvUkJNVCtpNVc4Qy9uZ1VXMXJKU1E0aWR4TXpHL1YvUlRk?=
 =?utf-8?B?RW9leHFCTU5VLy9IaWVPVnVQcmRpY0p2eXEzK3MvN0psR2l2WHFmTXVBTnhK?=
 =?utf-8?B?RlRnQ0kydnJFK25INnJBL0NQaExDSW5hb04wS2x0QS9SNmUwcndOS1E3SXo1?=
 =?utf-8?B?YmNaSkFBZS82VGVzeTY5anRTM0ZjbGx4VWZVQWRicVVLZmV6TWRpcTdRekVE?=
 =?utf-8?B?clAvRjVPTHU0b2hHZ25PclRmS1V5TEY0SnhhdW9YS2VPeFpwMTBkN013SFNr?=
 =?utf-8?B?bWFxRmJpQ0RNV0VkMWNKQnRHSEtJY3JOc1JlWmlIQ2lmWTJFS2Voem5keXRx?=
 =?utf-8?B?WHp1d0VQOVpVY3B1VnRBbDVwcUJtdDFJejFET1c5cnoyeUZ4N1gxMjRwcFMw?=
 =?utf-8?Q?oxLqmU7x+PbaSPc1+fBIAZ0TWicHWq0E/2Aru0U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a7d1be-5f3a-4003-ccf6-08d96193e6ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 15:30:11.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIDucLRCuxZk3nH/PncpEK7YaB1gSflLFg+M3VvzPKfWWuYrdH20xOVefFcw79J3SssDsog17Vc2+vOWHUYJDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/17/21 5:24 AM, Borislav Petkov wrote:
> On Tue, Aug 17, 2021 at 12:22:33PM +0200, Borislav Petkov wrote:
>> This one wants to be part of the previous patch.
> 
> ... and the three following patches too - the treewide patch does a
> single atomic :) replacement and that's it.

Ok, I'll squash those all together.

Thanks,
Tom

> 
