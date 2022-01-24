Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2704979CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 08:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiAXHwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 02:52:13 -0500
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60]:62880
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230401AbiAXHwM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:52:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g8gbnFqsbVJ28zPgxmcHY+J+AbNpyBC2yvMeOycRprNZ0M2gKX8j46MQkwn9imANI9U058X+ONUYegYlloHPJSvGoyk2L1tQhfUMrY2Bl/DsPdDppvgZ5bkc0/cUPmzEhYzACNTyVV6zeDXpgOz2P+GWTXqCrrBem9XCNMjYylpYX+P/CWmO4eYjDPfZ4TcpMdNjTwX2+kKhTdDLsVJUeambMECbbNZySgJMyP3aPP/jxylFEKJtGNbVfmMJx017h951q3J6Z8oXJW3DhZik0q+b4R7Y86/8/1XdbLD5U5VNLLWTFXxEep9xsZU87z9SSHJoDvg4IBLbMM4nHl5xag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ham5lJnerWEcbYJIUlGLY1E1ORne53Pk4hYHyFiJMv8=;
 b=HnIJeZ4Wp4GnXKiLlk/8ALKxDnisQVDnTGpJnfrXL6gTCj2vD09aV9+TJFIxqAEzP8Zw5o89miBwmEiz+zkFtzgP7RkxRmd0oVGMrHdsq/ICbLmTUN6XrGoh37+kznGJfLDYFr6dhmgIgw9A3u7GjBlBxyL/JGh6qGNoZEgj0t4OqBtitgCP1wJYSxeT1/J9lFppy8ChBaEqQgADwb3MuGbrpk6txPg5z/WMr8yGQc+r65qikhTwZ2NGIkhWXCpljb66A6L68qZ+drJLfsrsCEjnyWukQVLNCzxZD+R9Pr2PglPA00mXAl4se8AhAcChUsvj3G/CmHG+7BuFMeS9fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ham5lJnerWEcbYJIUlGLY1E1ORne53Pk4hYHyFiJMv8=;
 b=q+1HrCYm8Yx3U4aC1UQWGoLg8WCeFpE3on+tD7owa32oHHljGNXvcGtPrtkZPVGs3UqrRWL7APatcFzvlFOQMhlL7+5XZMxrmiLEwJnoKU6sKUaQ20G8scmVwD87yBgPIHL+d4IKvxnbfFaU50zm+/hNrdTIU1zBLichJI7TAJ6+No9qfLhH6J+4Mrz60a3TgzNNIbqORaS0kFXbnhdrho5a+YJhDQGXAcrrjdxt5u2EyECdpNPMx/8LGT2Y97VmUn6E3COJqnWO5ahpspr7ZN4Bu1xCACuqu7n/pHi1JOn1iS6g4UrSKMK5cz2Vl66rFJgk+XKlt6/O4hl6Wl5Nbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB3727.namprd12.prod.outlook.com (2603:10b6:208:15a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 07:52:10 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2d75:a464:eaed:5f99%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:52:10 +0000
Message-ID: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
Date:   Sun, 23 Jan 2022 23:52:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
From:   John Hubbard <jhubbard@nvidia.com>
Subject: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:a03:180::23) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c92c91b4-f9f4-42f9-4d40-08d9df0e6d32
X-MS-TrafficTypeDiagnostic: MN2PR12MB3727:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3727CC6F6846687EDA3B2BEAA85E9@MN2PR12MB3727.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3A1t/gdwzkbFgxQwCtAS+nOJVYy5VK3WWLH/be5jBh7au8mEV4BGctNKKRTFUVxlFlKxIXlbsv7bhS5ADG1dwrEB2zqvEKiVDC8+9rU/Fse8cAh9uSiU/OLbje6Db3XsJKff71KxgfZU0lf2rGKfU3H4ZywpYQoJ2iQFGtYwiAmvziw/D1KzRcyuSeOSc5GDawa2Ll8eZbdyHpUpnGTtYFHmgK3sgXjijaIOjwb0gLuQO/N80KGUlo2HFTAChR2gt7gjI2vNO6nwj2heqTwH9eiCiaf/zSg/YAJA7jeSzJ00YymtvtfsTBhYw8hBl4aXcWBtipEDmJPWA5UD9WEuITuWZwwgvAvQosZkQdpuxn4uHhWmL2M9Clrx1reIDD5LMKlDyY77IcchUIdDQqJOmpyT0+pAMo6UOjFTUlpUWv+XhZygA6V/ZcXarDCnehZIAwhbhzhF6Mqby5l2mv4X6AykmvhPCb3LXjpBQY7wm+v7TsbLXxY4iFU3mJpVT92F3sXfLBNE933zCsUBrYYq3PnhQ9Ygm7+0QMgQxVIMtEyZkcx5BwuK2tPQitZcIyoxDluU+HFfDIbDS0vzM4bwkOb1SeLiIFgLMBfpDz0uzNHsTQ74G/8XmLNyVIIGr2jTs/TUsh+PLylA7t/YXwsymgq8KofWWOu1vw5JOzL2N85AIV451t0DTXTLqzW/WBTXzR9mppq9Ge4pMAsxIfq4g49RKQM2jYLerNLFw02G6lxLsGYqkedK9UtDe8PoUugqlZIaSSrhmFGKpKk6E0lU1FNYzgGWbVFTz0x7Oh/w1LuOs7GkJbPdNccHk4I2BYVsd6ifCjAIHwPLVCrYdWD/BuyoACsDwoWrYlPa4aXFhLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66556008)(2906002)(66476007)(66946007)(508600001)(6512007)(26005)(186003)(316002)(966005)(31696002)(2616005)(6486002)(86362001)(8936002)(83380400001)(31686004)(6666004)(8676002)(5660300002)(36756003)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlB6OFBONTFaUTc4NkRuTk93dmFYR1M0SWxiSWsram1taHhvdE5LMk5IaDhC?=
 =?utf-8?B?R1dOMnJ5MTBRR0V4aHhpeUZvdFRsVzFoeEMxNHdOOGRHckh4amV6T2tmcW50?=
 =?utf-8?B?dTFiZ2tGRG51QWNSazJZcXN2SjRSc3BWdVRmSlI3c1RDa1dkRm5nUjhXZzhH?=
 =?utf-8?B?MW5OMEU0RUhOaFd1QkV2cmV6SDVUNlJZSHdkSDlZcWh5dUhTM3dZemRlcDFz?=
 =?utf-8?B?cWtIcUlEckNaZldXajdPWlAxM2RaOFRiZWQxNms2c2JkSEVPSDJLVUM3b1Bj?=
 =?utf-8?B?cE9NNm92SjJtb2hnSG4raW40Qy9YTUNtek1uK0wxbzVKSWxRVG9YcUIzVkRa?=
 =?utf-8?B?aG1pWUgwRjdQdWRCZTJyQVhqU3ByeERJbmpMWEVQM21mQ1NFbXZnaGRXSlZC?=
 =?utf-8?B?TC80U3c2M0pFY2VVMEg3WlY4SW9MRkVDR3FFZk82b3pIMWxISWMxOERxK3dj?=
 =?utf-8?B?WlR4UXphYml2VTlUZmZzdUxSWWg2ZkUwRWVUNEtrNS9nOUJRNlpEUnlMMXRX?=
 =?utf-8?B?Mnh1Rm55V2RSejV3T2ljN3B1YXoxQ0dadkpaOFc3SURMQ2FjMjMxUFdEWTNo?=
 =?utf-8?B?WENMYW1EMm9OZk9FRStjeWVIdFZ0bkJTTm1CaHhqZjk4NW5tNlozVm81d1Js?=
 =?utf-8?B?Zkk2U3IrcUo2c2x3cFg1dlVyL0h2dWZKTUZJWXZkNW1DRkcvOU41RkJjTmVp?=
 =?utf-8?B?QWdBY3greVRkalpFdUJ4aWlTTGc1N3ZkS2lBZmRSR3BCcWpydTc1RDRGRkRu?=
 =?utf-8?B?bDBnWE9EaUd2L056SjJTWmpZMC9zTEpjaTVSWll2RjcxMWxqR1VvS3U2bmEr?=
 =?utf-8?B?RXhDNkFSalhncjJuOGc1NjY0WTNZS3BoMXJMMXYwYWVjUmFpd3g0YldKZ092?=
 =?utf-8?B?bHUzUmx6OFpWWUxIdnFITmxsMXNqY29zbWNDM1BHbWtmYXA4Q1FjWjl1Vyt6?=
 =?utf-8?B?SStJOW9kd1VLRHVvbG9vR2RGbGZVSE03Y1JXM0JCNXVRMkVMWXc0dm9CYWYr?=
 =?utf-8?B?Y2RUQ1ovRXlhRmJlUmQzMW93a2Qrd2N0bXV6QlNrblZaQ3hoTXlwWUZKN1dH?=
 =?utf-8?B?OGVIOExTd210N0dKUTdHbUVHNFg1WisvNlZXdllCWEFmMWwyTCtNSXNlQm9Y?=
 =?utf-8?B?NE5jZnJjOGROaGtxbjVXd3VENFRmeW5ZcGZtVmpaNmswV0djZGlLOC9WM25i?=
 =?utf-8?B?WW5Lc1F5U3lxaTdZVDFmanRXQU5TNTdaZTJXUmJNTDJOYk03N2JSc3dFdUxi?=
 =?utf-8?B?S0J6RFE1dnU2ZThtQkEwN0ErS0ZRcWxzQlpRVFVEbWxYYnpUSVl6WjlFWVVs?=
 =?utf-8?B?TFVBUGYza1BhemlmSENwblJNMTNod3h6U1p0YjRuNGtRUW1uTm9wd0hvSThl?=
 =?utf-8?B?bWRzMzFXdXFjeEp0a2M5RWVDcHh4ZWJKQVdqMzhjODc1VjZlRlZZK1AvZ0Yx?=
 =?utf-8?B?RWtUWnVDZEJ0UWRlV3hJR3Y1VTUxZGJMM1BsVkJVdE12eWY5bXVpSFBtMGNs?=
 =?utf-8?B?WTZpUG9WbTdQNnFoL3p1bUJDZUlwNXI1bE1iSWRJWHBLSUU5VktPREdtN2k2?=
 =?utf-8?B?RDBoUy9Mei82My8xKzYwaVpMS0kyMEwwclU3MEFJVmJOSHNabHNlZkJaUmlU?=
 =?utf-8?B?WkdSbjNJdDk1dkVVcVFYT3FzZHhXdys4MGtOcXdyOXNwbFNzR1RtSWV2dkpI?=
 =?utf-8?B?QkdjbjhURldRZk9PaVN3R1ZHc25xVmIvVzluV2JWZGZoMnB5TDBTWVorTEgv?=
 =?utf-8?B?MjZIN0wrejh3Q2tZaU1GUzJuNHNpMVpBTXZHZlNaaGFkOERiSTBMYURDKy9H?=
 =?utf-8?B?RUpUSFhqK3JLNlYyd01xYmhJTE5LdzV4YXM4NUhTOGRuY3lOQ3NMc1ZscTJI?=
 =?utf-8?B?dWw4Um92b09rOVlOaTY4ZmpNcktGNDdNeW1HS3hHdDZaYTMwcmdHbUphcXE2?=
 =?utf-8?B?YlZEMmpTU3pFOGlaSzY5UStDMVo1MFZPRXNaQ0I2V0VGWEpHVHJDdE1QQ000?=
 =?utf-8?B?dndsL2ViWk15QWtIdy9qUDNLME43dEFBeVN6QTg3YTg4NjhRcUp4VjdGcklw?=
 =?utf-8?B?c2hVemNkbjMxNWxQSGwwQ0ZQVFVtUU82YjNVWnVucGVUakhiSjlZdk83bkNU?=
 =?utf-8?B?MVcvMVR2QlViM1hTRDNTWUxsZU9tamN1ZUZDbzN6aXNhcG9rQ01FbFMrYWMz?=
 =?utf-8?Q?6IKwkhFphMHxqFRO/rtez1E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c92c91b4-f9f4-42f9-4d40-08d9df0e6d32
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:52:10.5903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ppo20eboXLBzK5IHv8W3/pgq9WL4rnCXJ+PIT0/Sc6tp2vqfTxh/7QaG80L9ZTRkBF4sxfJUnBRaZXWO9oKP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3727
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Background: despite having very little experience in the block and bio
layers, I am attempting to convert the Direct IO parts of them from
using get_user_pages_fast(), to pin_user_pages_fast(). This requires the
use of a corresponding special release call: unpin_user_pages(), instead
of the generic put_page().

Fortunately, Christoph Hellwig has observed [1] (more than once [2]) that
only "a little" refactoring is required, because it is *almost* true
that bio_release_pages() could just be switched over from calling
put_page(), to unpin_user_page(). The "not quite" part is mainly due to
the zero page. There are a few write paths that pad zeroes, and they use
the zero page.

That's where I'd like some advice. How to refactor things, so that the
zero page does not end up in the list of pages that bio_release_pages()
acts upon?

To ground this in reality, one of the partial call stacks is:

do_direct_IO()
     dio_zero_block()
         page = ZERO_PAGE(0); <-- This is a problem

I'm not sure what to use, instead of that zero page! The zero page
doesn't need to be allocated nor tracked, and so any replacement
approaches would need either other storage, or some horrid scheme that I
won't go so far as to write on the screen. :)


[1] https://lore.kernel.org/all/20220120141219.GB11707@lst.de/ (2022)
[2] https://lore.kernel.org/kvm/20190724053053.GA18330@infradead.org/
(2019)


thanks in advance,
-- 
John Hubbard
NVIDIA
