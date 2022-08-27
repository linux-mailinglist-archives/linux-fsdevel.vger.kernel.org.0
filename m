Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C069B5A3A89
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 01:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiH0Xz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Aug 2022 19:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0XzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:55:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736EB4D819;
        Sat, 27 Aug 2022 16:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZJXm8s6hhjpbk7PyjgsoTG+rrszOpT0OWVupJo6s+AFsjs4nLKOGjgjWgP9283IzPbjGWAqn65HeLozI9B2X2wOExzt5M4/NKJfqaYw08hVfA0FScefa0j0xvJdJMJTY3MaulxiNY/ZKnYy0kttNlHVA+Js21jthVtZENnYKWYzeFI/10g3VAlm4GVUkAHRg5Zv9pb5/cqgJ3lorPWd1S56NiRZ7xzIUFfUYzV+6a0jpw+qDlNYwQwPxb5tyItussPbnYsF7f59EWlLTNx0Y2oETwRiqyB/CHGCHi3JGq7947J5rRH3KKTHOu9BDUrhz3I3cuEpXhdQXrwLwIm6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLHyZYxrjiD6wsQvoNSTP8SCSq4ZaNOWlYB8CbnAuZg=;
 b=GxHXICIiv2PvGnJZy8M6pWgbQT399Y/Ky2LEJCvC28nW8eNb47urJn1lE4FAVuqIXeKk1b4Jd8GMstX8L0snKCMVnL6annbeSvlTopvZxbtTl41mr22XMeIbmR3zEKkjiJkX3iTVdok8E0RHuq6wvTharBMl6+/v9JBSswxREwgxIrGC9hCxFcby2SAReeV0ErXDxbKak22SDrssKTDjQojW/fu323vRk1Rufawi1ny0OviJuWHzQFrx3rcwGTtXVGnKvMfqrJGXpDfcxExoS9pA3TyG9WMPrwZoQSaejK0xl72H1KDqPSfw+dFIZkd1xtL3rTHXPI0qJ9FM+3iQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLHyZYxrjiD6wsQvoNSTP8SCSq4ZaNOWlYB8CbnAuZg=;
 b=pSVlAeUBa6MiEtQMU8nGQ8AmE/VS+BOlM5VH5etDKI+oJ2NzKz8JuTqJjryI6YjwBsJcqlryy9TEQOWdVBl9um12IC6s+soKzOpG/0iM9X7EHGEBQ9cYKevhBx/XYNMVMRqKA9G+9V/+41xZ5/L+J/Ujmzk88mA2n5RRwCSA3dDgsDN3cuvm5b1ljqa7U9/N6JhFM7HDgkPsrIyPqxfT1/VWOeM0Pc9My4FP9QWjm+qh+Zi93zPwlQYNfU7wkNtdBaWg/ncgqu4j8URyiGgoaW8YvUTRxLDLpCGrSNcNvgaEgpEgufMmV0YBw4jEV+gP12uHVSq9Bm5o2daUR75Ktg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM5PR1201MB2555.namprd12.prod.outlook.com (2603:10b6:3:ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Sat, 27 Aug
 2022 23:55:22 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5566.021; Sat, 27 Aug 2022
 23:55:21 +0000
Message-ID: <353f18ac-0792-2cb7-6675-868d0bd41d3d@nvidia.com>
Date:   Sat, 27 Aug 2022 16:55:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/6] NFS: direct-io: convert to FOLL_PIN pages
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20220827083607.2345453-1-jhubbard@nvidia.com>
 <20220827083607.2345453-6-jhubbard@nvidia.com> <YwqfWoAE2Awp4YvT@ZenIV>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YwqfWoAE2Awp4YvT@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0068.namprd05.prod.outlook.com
 (2603:10b6:a03:332::13) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44385745-3554-401a-102e-08da88879a0c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2555:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FMVOCS0djdg/GVkjQsYjQjz4ArB0cuA/dMSf196doL0gVbzLeC8eVvrpZ9RELyoG1yYMiSopkT2jQtFdtH89JNBN3ECoCMXxrZYpDtJWU6HSY8/phe9DuKELy2mwXFF2fI7RW72GDlQpyAuDBXSwj2D//5lVAk2+0nfU7SoAkBS86+AtJhVXpW2jfNntM+WNwpX3raDDyivNeruzEgFhw0w7v4hIYjb3XLToutYtvnnT08H0VHFpklBw7HXtvzovbb7b22m7sEL42a/kg75I9C2Y7QuPwgvB3B5ELJ9QK8PRVEeoo5M4okEOae20hpZQyf0VzDTvWAh8DIorVuy8fNq49bBbKMZLk7Qo+xdHheSsjAL8JcbO8u3eSMRxL8WCVGoWsrMJKlGSdT/hjqzfju7JUxtNATonaD2VQtM/2eqgybap2D11JZCCP6weoLOU0cQAJaULaZiGOw8GTsXI7W6zF1xFL2q1EcvBODMp8BCZudeFdB2/IH1ANEMIYboq9HK/f42C+8W02iclRG2zoO8Ig96CcKKZViZVCju5WhwZGVJgsdB7Um2rZbREQZhLKwqAfejYrAzx3L5S7TUM1vtvdlcYEQ+bT4NdXta8d1RyI+WOFtVo7nxHD9f3JolDzqIRYwmLDyCaOgYSr1g8Yyg+VAApivVaKrbgPhUL83iTMcyNblwxqSERZ/bPT6HpKkwdf7HY4nr9p9vkAZN9w4ZXlTz4EsBVEmA/Rw6nJXKkySmO1cgymr/1yp0Lv9p17a2lO4l/FTF5PEg8iw9fUjMrK8KDdYwdq7uYEJz3Ieo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(4744005)(6666004)(41300700001)(186003)(26005)(6506007)(7416002)(2906002)(6512007)(53546011)(5660300002)(2616005)(4326008)(8936002)(8676002)(478600001)(66556008)(66476007)(66946007)(6486002)(54906003)(6916009)(316002)(38100700002)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVJyck5RNm9Mdm9sWnlFNjRmdXZoLzdHZENMQ1h1Vit5RjJZeHJaVjM1WEx2?=
 =?utf-8?B?MFcwSTVueTdwOCtjb3kvRkkxRlZWRnkzbUlEaE1Xa0I2bDF5ZXZ3YnIzbGwx?=
 =?utf-8?B?NWhYWXpNMWREOWFVVm16Ly9SVEpmSnBiZVRRZWQwWWdXL3NFOFFLRVcwZ0VF?=
 =?utf-8?B?OTlySU14SmtlS1ZGWThxM0NhWHluK0tNZFR0NXdRYVlVbFg4MzlBQWV5dWdq?=
 =?utf-8?B?bzU3SG5adk14SUNPMk5aa3p6bi9uajZVakc1VGF3QVNYVFZyUjcvcGVWcEc3?=
 =?utf-8?B?ckU4dkJrNHl1MTgzVzFXQlQzRWw2RnlhY2ZrWUIvc3RHSUlSYUVFTngvOGM0?=
 =?utf-8?B?RUJBMnJCakgyaEpmeUp6WWh0aFp5MkxGa3JmUHgrK2g1U29qdjNVWFErMHow?=
 =?utf-8?B?Q240NklBYkZLRzlIckhqWkxaa1dMRmVualdJK0tjUncwV0FRUHZMN0oyV0VZ?=
 =?utf-8?B?dFpLRm4ybEpYQTVSUjN2UXRCd2pnT0p2QTc4TDBWUTZvNlJCRzNSa0VKQXZR?=
 =?utf-8?B?ODhkYUVIcFdVTGM5U2NQdmZMYVFwTFlJcGloVXhGcDhSNEFBa0JtNE8zSko5?=
 =?utf-8?B?RElzTlN3WElwWnhTSU1qWnFRZXRGZmlWMnNFSlJMV1ZSU25kR1R5YlJFM29U?=
 =?utf-8?B?elRkbjRnNE1OYjJiR0pHK2VzN3hOZjU5bkx2Uy9KRGlrM3cvZE9CdmdaaGdM?=
 =?utf-8?B?WTl5VndtSGRCZHVhd0lrc0hBNnl0NllLVjFTNnNXSW1URDFhd0MxMGF3VlA4?=
 =?utf-8?B?NzA4UHBEaE9ZUjJESE9pTTZPdlkxa0lFNEJzNGZMR2Y0QVJnbGFYa0dKVmYv?=
 =?utf-8?B?RmhnMHo5bnJHdmcvZ0pqNzBmN2ZOT3Q1ZkhIMzBMMlNBb2tPT0pWOGYzWkRl?=
 =?utf-8?B?TEtub2RINlBGRXgvZnRKdk1aWWUxRThaMzRJaUJnakR0SWMxbnFkeUtqY2dD?=
 =?utf-8?B?RDdKOVVvMFdVMFdaUUN5cnZrUVI1RHZtaHJiaE1zYjh4akpvSmxnQlpwWVJI?=
 =?utf-8?B?cXE1Wm1kR2cyc2NFVkNTNlhXcnhaUXFpRUpkSmlKT1RZYXAyYUFvaFY3QjRD?=
 =?utf-8?B?RUsxeTlGMFMvMmZKUE03L2VLNlVuZ09ZTEUwY1RzL1czM28rTzIvVzlBSlRa?=
 =?utf-8?B?VjJXKzBxaitINjhEVXU3bnluenFnSXA5aHAvb3BkSjBnWTdKdTFseFd4dEY1?=
 =?utf-8?B?UCs3azRDcG9uaEY3QnBTc3pLUGc1WUQxZkhPTXV0R2t1ZnE4WCt2cUx2TVVH?=
 =?utf-8?B?UXNrQ3JMUFJHZTdnWTcwY2lhSzlrOWJGNnVFSEJpbkx0VDZYWVczWGg1L1Bv?=
 =?utf-8?B?dWVlalZJWldaQnVIYUdyL2prcVowTUJOV0RBQWFscXBST2FrS2RhWFZoV3Ir?=
 =?utf-8?B?MzMrZXdaSEhHdFA3UllyWDRzUGFOQnEwL2pFVXhtbVB6OTgrOVpQMDZVY3NN?=
 =?utf-8?B?NC8zMEtnQUZtcUQxS3RsSE1GNWVCV1dYbjF3MEJ2bncxc3NKa1lVdVBrTFZx?=
 =?utf-8?B?QVRHTGRvUnpCRWg1b3V3T2UzTk1WcDBSZ1gya2VTRXo2aVg3cDAydVNjQmNh?=
 =?utf-8?B?OU9kbEM2UHh1NmtPLzkyRnhSN2xXZnFIYXBERW01Yk00SEtVc2Jla0hPVlZK?=
 =?utf-8?B?L2hQakQ3cUFpRXBmbW9iZ0pjZnhsc3k1YWhwUGxuQ2IyS1REMGFpYnBiTFlI?=
 =?utf-8?B?ZjlNYWw5b0Mrcm5zdjZYeFUxOEE1Y2gwMWRGR3docGhDc2VYamxpaHZPMmcy?=
 =?utf-8?B?bmNsdXpsam56OFQ2NU5KZDA1OWtXWmcwcE5udGNyVG5acXp5clBGZFlncE5z?=
 =?utf-8?B?ZDJBblUrN0MyMTQ3MzIvdjJpZGxEM3B2cTJPSlFBNys1NlZ1NGRHMmh1c0w2?=
 =?utf-8?B?SE5JNHk2NHdEcjM5S2owby9LL0NWVVlDUEZEcmR6N1FZWENGb3pUTXhPcDZv?=
 =?utf-8?B?eTNFWmR0U2xEaHEyemtiV200cWZmWDk1MnVFQWhOUmc3eklIRUtZbERwbzhP?=
 =?utf-8?B?VHVkandCZC82T0w2d3JnQVZVSkNvblBnc1hVU1poSkRHTENocmJ0Y0doOEMx?=
 =?utf-8?B?SWxYRE41a2FKZ2wxOWljeTlRSmVzR3pWVTdETnlFTDZxakFIbzU4OVIwd3Yy?=
 =?utf-8?Q?C4DEZxWb23ampuR6SenapifSy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44385745-3554-401a-102e-08da88879a0c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 23:55:21.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apsHO4zqpZhGZRr6lGRbhwtUgOTTvjO+qeTS6+QnoBNSW1SORCrePMWV1tnUeBN/s2qw4CZ0UCA+KCntncPoGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2555
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/27/22 15:48, Al Viro wrote:
> On Sat, Aug 27, 2022 at 01:36:06AM -0700, John Hubbard wrote:
>> Convert the NFS Direct IO layer to use pin_user_pages_fast() and
>> unpin_user_page(), instead of get_user_pages_fast() and put_page().
> 
> Again, this stuff can be hit with ITER_BVEC iterators
> 
>> -		result = iov_iter_get_pages_alloc2(iter, &pagevec,
>> +		result = dio_w_iov_iter_pin_pages_alloc(iter, &pagevec,
>>  						  rsize, &pgbase);
> 
> and this will break on those.

If anyone has an example handy, of a user space program that leads
to this situation (O_DIRECT with ITER_BVEC), it would really help
me reach enlightenment a lot quicker in this area. :)

thanks,

-- 
John Hubbard
NVIDIA
