Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEB061644E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 15:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiKBOCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiKBOBn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:01:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93EF205EA;
        Wed,  2 Nov 2022 07:01:04 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A25BQWF017267;
        Wed, 2 Nov 2022 07:00:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=A7JbujmLBdq1mI4LPgPJ1ZeKd264HzWr7VYMaRoMG9A=;
 b=i5NRCrT1QJOWrI9MXSL+mGxsBH51xoktUBsPwnfNXEzE/gYxq15uX4nzZLRX/fGS58F1
 3Is66XlBkckUb26iZD1I6/vqjalcSbHPUgkAwNqGP8Uk5XD9/IJ3qvXuoGonwEMzta23
 oPCTmTJ4ZmSnL95TnAy0FArWGu66YC75CiJ13cYpO1mg19dkJVYTYd+HGd8DcaQilLzy
 B8p4uNbAW35tg1+1O50ETqvW1maDDeg0L+vsefDgCJxyfnmXrWf7rtp9IKQWaIeWsPBH
 54fOSpOrEVAULnH3UA3gEjzAWyO4kWlJXsS49JsMjlifSLJALjvxOjNBdS8Wkz8x2zHv lw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kkhd9bne3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 07:00:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1MNOztgZXM599HTQ8zYPpa1MWabwoCG5oTrWBEf9YzMbsBC1vEZ1NpfaRRmYNuJ1mYYY04OrTgrx8/crrWYJdJeNkVkxs0DRPuDWfQ63C2Z3jgY2ztTEm1hcsv5vmXoeobX/2l/LOzA31YTqg/UUBhwKvoG+dEsj+Sek6j8diDKXusD2A62Oa2/wPjIUkl+vZUxwnKJXB5r6zHzajlcLfCs8ZNoE5kMU41zjNRK/iu+e+4XpjWC5fbE/UkCskxq2ATOzDZfXgvYpXyBptlz3kdL9zg/UZqhjyxGfIJ8mpR9XVJogHN0xmT4Np8Tz5BhXDDaRztR3F8XVeSkHXq15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7JbujmLBdq1mI4LPgPJ1ZeKd264HzWr7VYMaRoMG9A=;
 b=UEYrWBGhpf96S+8gXhK3SjSrGHS8FcuUf3hbnwYxBzvoETmf7Cr48+D2yhzTU3Wl8Xr2NUi3a7Z3eG/aG9k5w15DVzKfyCU9Qp6QAmCVb0cSXhHK98qwjlUV5w/45ssE/qsUC0cxegRRHfuGPkNW9JyoWpMxAWu3nMeWHBhawYl6G6mtW1F0ZbQG4Aj8KCfJLY8TR6SgJjfxxKVXkh8osUjsJf3u7YOiWVDOqAHqbxhPXlTZ9Ya59MA0JXULsWuN8WP+KdtudjKgWPjFUIYft6J2mKIPi2Y14KFdUAtOtIJ7qbyiCe5ieSZaM86+lfg5dmn1CFcwRK3i5YcXdcxITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by MWHPR15MB1856.namprd15.prod.outlook.com (2603:10b6:301:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 14:00:33 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::6328:6d95:ed96:b553]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::6328:6d95:ed96:b553%6]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 14:00:33 +0000
Message-ID: <6a249420-c677-d8ea-c44e-d5eb5c20b6f7@meta.com>
Date:   Wed, 2 Nov 2022 10:00:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     David Sterba <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
 <20221026074145.2be5ca09@gandalf.local.home>
 <20221031121912.GY5824@twin.jikos.cz>
 <20221102000022.36df0cc1@rorschach.local.home> <20221102062907.GA8619@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20221102062907.GA8619@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0012.namprd15.prod.outlook.com
 (2603:10b6:207:17::25) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|MWHPR15MB1856:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aef34c-5403-4a51-4039-08dabcda9c01
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4ziJIhvf0zZkRF/fPL9t+QLTJJ4ZeYHM50f3DYpCSLMDisV+9fZ2znLr9zLOtHj+0XJYDeanLF+Nm+FMzdXJUwmBHvoEzYMiJnmp4M/lKe113D4P7PZ0i5PdFGFdMQzZ2jpI4Lrzprt8OLoAALebxdPbnyWTmF8DLzdxBqjFi1mxdf7ZIBA+RrLkljFONnmcp+D/m5wUju4bbVgsRkumBEa01d9Yk0dAss+YZstp0v44bOFNvHt8mccZUgwkt8EFYUjWwpxt3iVL9xxUCcN+66HcOfeImoQw32GlQ1grxqV0MmJ+9g/PGQPBUHmPug178NPHDjYQJrR0lYyPYzbpYCZzfN5gE2YABULcHr4q4jEQrHt76LxERFa1P2IvC9vGYVK+oEuOR4nd2QSF1RZyFC+U88eHMNvtbViGQqSEvj/Xp2uEO7TnO+lqgmiZk60be9h7aPlCoKKjrmbdvcCXuUd4Shu/cRFA71EItwoeQvimctR8Kod2OSl5ViZpJwGYKPHuuW5bJKOA2S+LCbxLGsvMlZxScGz/42gu1p2XkCDZasJEaGGctu2h19jgOnHfdKFbKoUGgFZr1menuoZN/9dhD0JD4xhwR0EJTxBql7DvfyVj5bDoeOQdSDhdFKHY+hY0K28fQ8es/AAc1RzXeT1r9dJEotUWWioTyrlIGviyBqi1pVWN2nDe+dGZoL29iiUgDTJ1gr6MZPO01IekxiEfXGsoLyNmpdxIkjFxwlodUJfiwM4sjk6IfwV9obLN/uYR5pQIIwONfOnfOqGspR8xnuPvW7IUZNMzjlN1oY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199015)(8936002)(31686004)(86362001)(2906002)(478600001)(83380400001)(38100700002)(186003)(66476007)(316002)(66556008)(4326008)(66946007)(2616005)(41300700001)(6506007)(53546011)(31696002)(6486002)(6666004)(36756003)(8676002)(54906003)(6512007)(7416002)(5660300002)(4744005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlSTmVRNzFyc2g4OXgyS0VReGxTVjFWVXlIRHRaVks2OVlMSVhWTks3bFM0?=
 =?utf-8?B?eCt6TzlFR0F1dXZZaExxOTd4eE0wUnBuaGZ0Mkx1T1daU25xNVZoak95elBF?=
 =?utf-8?B?RER2aEdaRXcwUjJ2NW00SU5pYjlQTUF4QzBJR1E1MzRydldjaVJPWjJiS2k2?=
 =?utf-8?B?UXcvVkpKOGxhMkxhTUlVYjBTdHlHdktmVHpmaGo1aW1QMnB5RTMvajVBRklY?=
 =?utf-8?B?Ymx0cmtmWmF1aUgwQTNja2VKMDFLdmMvK2gzZnFiVzMrWkhDampsZVZ4MVJZ?=
 =?utf-8?B?Q2RNalNEQTBnSVZ2bTIydUF0dlAwMElORFVKQVBpaWc0aUFYRUY1b0dmaDI4?=
 =?utf-8?B?NEJXTEdvd0orQ0QvYXZuNE9jeWkrQnVrZFB2TUdWM2VTL3lUaWxLRGs5QXF1?=
 =?utf-8?B?eTBoRFhEVXBWa3IxeFppc3dJOGtueWs0T21LZTYwVkpxUlFrcERJZFFrLytu?=
 =?utf-8?B?d055dHVIMERyRjBwOXRVdlZabHl4QmkxRDZ0S0c1Zll5ZFhOYnhYbHN5UjFr?=
 =?utf-8?B?NlNNemlkalU2QlM0cFlOTU9vdHVGWlhsWnB2YjE5TnoydjVJRC8wZ29OZFVU?=
 =?utf-8?B?aEhObXZSYUFITEdacjVPWVJWMUpCSjYybjRCbEhHRGk0TFFOQ1B2UnpvUmdW?=
 =?utf-8?B?TlUrNEtBcUN5MGdnSytMRDN4SGZ1TEdORUVEU2Q0Vkx4aGZaZ1J6TzVDMCtw?=
 =?utf-8?B?RzZrekNKYnk5dG9KTmk5R2M5WVN0cGh2YytOakJRem5jQ3pzaVJ3aTRUMUx1?=
 =?utf-8?B?RlZ2Z2FRRG9xaDEycGtKUWI2M2h4alpjR2VHeU50aWcvT2k0cVBQeWJ5aVBE?=
 =?utf-8?B?L1hHRGFLUGlHZDFpUjdldVhmSXhmNkdOcDRPNkF5VXJEZ01idlZhUEMrRmg2?=
 =?utf-8?B?SHRyV0pWd3hHUkpsY0dYUldtMmhQbExEMEFocHVEUHNIL3VJeVJwTXdudmdt?=
 =?utf-8?B?ZDNnN0w0UHN5dlUzaFRHS2FYU25sY3dBOG5FejZzWWl1ZUVpSWtQSFFKY01P?=
 =?utf-8?B?NlBad1J6WGlnYTJqOVl3dk1NeWhHR29zNjk2ZFRoTWlQQlROYTA1SE4vMTJj?=
 =?utf-8?B?N3VKZHdIcVgxQStUR2I1VkVwNHgyaUw0ckhKNWpoL0RYRkl6Y1Z2N0dnb2Vh?=
 =?utf-8?B?aGNZT3VldXRuMGgreUNLbTg3VlZOS2NLTEJvZkk1NTkzY01xcDR6amwvMWEx?=
 =?utf-8?B?cWdVNTRlYVdkdnBKMnlFUnhpMWNIZ0Z4TFNBbE1FUEJtNVhXTmFlbzM5QWJ4?=
 =?utf-8?B?aVVUWVppRU1FV2UxOWFvU3ZoWnZ0RHdjQ04zWEljS3VlekRsQ1JUV1U0V3hO?=
 =?utf-8?B?NkYrdFZWQzh4SHdpeS96R25qRFc1bkZXUnRRMVhsRURsMW5LQ3U2T2VZQ3Nk?=
 =?utf-8?B?N3BBZFhJM3J4SHlrdWd0NGY4K1BsYW5hVFoyeHl1RW0yd01lWkJ3eklRTndE?=
 =?utf-8?B?a1NrN3VmWU5yNk5ETHAvakdBa0pHQU9QSjlVV1FkZ2hSbG5wNkw2Z1cyRzND?=
 =?utf-8?B?ckU0OXg4WnlvWTZMMkhKZm53ZjhHZ3QrM0tWYU1IWUFNS3hxbXJPTFlpZDl2?=
 =?utf-8?B?cmJBZTA5TUVXMHA4UjBxbjNkMDF3UFRrbUVocW55aStCcFpaRStYZVpDU05P?=
 =?utf-8?B?b2tVS2xLYWlKaTZDUUVob0Q3clFTK2IrUXk2UFNBbEdFYjJpajJreG5OaEJa?=
 =?utf-8?B?anZGU1IrTFo3ZU5TQWsyQnZZdURKRlpiZ3pBZEpJUmttcUdjeFUvWjREbTI5?=
 =?utf-8?B?K1ljVTVDUDE1Y09RbU0xVjVNNlh6WTFBcThYQXFwM0pMbnV2OWRyMnN3QTdR?=
 =?utf-8?B?eXR5VTRSSm9FMjlIYnAvbHlBMjloTGRPU0VKWDZ2cHFXZTcxM0xHNGlqREdM?=
 =?utf-8?B?VjdzWS9OK3RkSmIrVGFpKzJmdjZzVytVR0x3eGhKMzJNMFdlOUpLT1hwelBU?=
 =?utf-8?B?anJWdXJuMGk2YW8yNngzdWJXT0cxN1ZZQTJkeXNYMlJDNVNEa1ZCTmNrcGx2?=
 =?utf-8?B?ZHdQR1JVaUp0R3M4Z1o0YU4vRDVnbjJUUkNlMnZBQjhsWXc2SkIxS1haWHl6?=
 =?utf-8?B?RS9HakJrUjRoTTE2STI3MDZ3OHZjbDJObC8rT1BXaHc2SjdwVC9TNjFQZGNi?=
 =?utf-8?B?QlBJVzlicDF6MmRuZUVEcXc1aEozZEZoa1dMZXRQRmU4bXdNb1VzeVVaZlV3?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aef34c-5403-4a51-4039-08dabcda9c01
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:00:33.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzPOH0fm44fLZs+wgX2BGbBoOHBTFsN1wziF3ogMSfmul6kt+5BMAiOnp8nQpp7S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1856
X-Proofpoint-GUID: jNmNmhrVNNmxTjH8mozn-E5Afdhelgyj
X-Proofpoint-ORIG-GUID: jNmNmhrVNNmxTjH8mozn-E5Afdhelgyj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_10,2022-11-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/22 2:29 AM, Christoph Hellwig wrote:
> On Wed, Nov 02, 2022 at 12:00:22AM -0400, Steven Rostedt wrote:
>> It really comes down to how badly do you want Christoph's code?
> 
> Well, Dave has made it clear implicily that he doesn't seem to care about
> it at all through all this.  The painful part is that I need to come up
> with a series to revert all the code that he refused to add the notice
> for, which is quite involved and includes various bug fixes.

I think he's mostly focused on finding a solution that's fair to the
rest of the contributors.  I'll keep working with Dave on ways to
get the lines in.

-chris

