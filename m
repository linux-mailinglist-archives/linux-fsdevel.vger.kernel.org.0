Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2D64D74F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 08:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLOHhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 02:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLOHha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:37:30 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2091.outbound.protection.outlook.com [40.107.8.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1EB2CC88;
        Wed, 14 Dec 2022 23:37:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg8JcfrKX27+lw2c2p87RvEKb/Y2L2KBjv1Nc6o6EaiCv3pt4+GJu3ipH0/JjOaZPGOB/70rB4rs0Lqf370dB3OMwGkc3ZTI4GH9v3wEVA3kKwrSmJpAEdF6y8wF8DDcGRvMZJmMpxLHshqwfNmm2YMC8RduM6RZ7O65fwnSEJkcLWCpJSA/1Gcgm2DSu9T99oFR6MqPKWz3k8U0ir/hhw6DVkedXELLdJFJj1FZr3fnsCgJx/A1lfJ0zLNeJJUcKrKEIVzlL73t7KT3pSFKoh8PC0rfS1CNa6uvk7lEW469h+Hsg/WvhjjLZD6N4Unf8ppDetGTz/Rddy8imtxM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFg0m+DAvWoVumOTqcULiiYDa2WxmgOdj3ivRzU1rx8=;
 b=c7jgn7vMxJJvKrrkGhkK4ZlLDvDxWoTi78aqxOQdYQOvHzIKYIBn2a2WuZ01Qnzq1aG+ip7g93RrluaDSv2iW+03r+ziPV4i2QB+uVQQADR1SnvJAaZ5kLYOR34jhaNrY+0HJFAPt1vWI4WzCnrqN8xJ9H2NkNEcNej3xiDA9Ea3c2G8SU63U3q+bIw7E3VOkcsXgoPMPhTtn0XJyKLfQv2l2tXTzdGzrKEzbsF4cx1ru7rsGHGPajdz/WGOVUFQvPrqrul9OgDwTwADd24d/QUqnh65s4y6xD+XcR1PbIsNCL/Wzd5qf+4s3+bFf9foppLikESw2OhhWyrE96rp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFg0m+DAvWoVumOTqcULiiYDa2WxmgOdj3ivRzU1rx8=;
 b=CUuFocCNZVXuO3+HN47sM0ai6CaLFuKRPIsZBUD+H0gYiRGOeqB5JS1WbRthmaEp3Y1RmrH5MOC54S9IKgs/+BLaf8+w+TW+NITsocI1VXqxfX91DcUSC98EOUqEtak9548RKUJ0KKy02HOywv2SwNdei3Q5U6FZbjBv6jkXB7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AM0PR10MB3234.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 07:37:25 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::722b:5d41:9862:10e5]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::722b:5d41:9862:10e5%7]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 07:37:24 +0000
Message-ID: <68e6091d-e665-bcd7-0c19-ccd80635078e@prevas.dk>
Date:   Thu, 15 Dec 2022 08:37:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [GIT PULL] vfsuid updates for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221212123348.169903-1-brauner@kernel.org>
 <CAHk-=wj4BpEwUd=OkTv1F9uykvSrsBNZJVHMp+p_+e2kiV71_A@mail.gmail.com>
Content-Language: en-US, da
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAHk-=wj4BpEwUd=OkTv1F9uykvSrsBNZJVHMp+p_+e2kiV71_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0026.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::25) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AM0PR10MB3234:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2b41c0-37cf-48d8-74da-08dade6f3565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FlXPqllhNWLzdlkLzt6gUl4cbgdvPi1cFSDgrLzfwEsUSTVdU7BEOvz8jK182TQUmvD7dHBWiX4xoEuF9EeWsYCIBXDbTuggCJ1sL8lxyGoac3dWvITT2OuAk1wsTN1xqMJWiqcTHrXQwV7Q0bYZe8ahd30H5o602NTUrpsiz7AmzXyp0TtY87jUNXKagS+6heaeoo6MCdrszQ+hbEljolCckoaIYS7DlNc2wx+u2b8IlerPSFr+VjxI3MK6sI+D/HT2nsxhtT5HDF/RBs8AmO737Vf2Tn9ZGSuvTSQBFwB2pEz51ePd8E2UnOZFLfyhzIHeXGp2ujsew8WJc3vY1GdY4xpndHeVjWWXyBV6mo4CMby4NBSfYvW8eHlgUm2Yklcl9q8LdxYhI0FMLNC9KLTZGNbwKhIxeIOjO2odMyjZqjzf4xY6WXxrwXRvNG/+IXFHVLDuPQNFbo2FW46PtKTGMpF3Ajzem34SSMABZ4juOJGdFShwjI1pYylvNdkfG74STEolt5Mb2SVY2AhWL3fUhy1GBht2fdCJ7rO7xSP47PrRwDa6auUj6h4OLazCSwgFPnDGvhq3N9+Gz/2LIQG0uftJCg9+HodXtSUOqoWQcs82vGGIz+bQcZSpDEyCBXVwgNFDSBznWP6IoitcKepgfIxfRM4WyaGpzX+/PWc4HxTe0l+xMyGAUkW73HhWKVaNhxtF3Kn2V6iNMA7hFWOJLy7yqEaD1HitrR7njVjBPszWtIHr6tadCEk+tb3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39850400004)(451199015)(6512007)(53546011)(52116002)(186003)(6506007)(26005)(478600001)(6486002)(36756003)(31696002)(38100700002)(38350700002)(86362001)(2616005)(83380400001)(31686004)(8976002)(8936002)(44832011)(4326008)(66946007)(41300700001)(5660300002)(66556008)(66476007)(8676002)(110136005)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djV3bVBuZmFOa3N6OVVOSFkxSFFOaWtGM1JaM05tZ1RTY0hNTmJ6M1hBWXd5?=
 =?utf-8?B?RW1uWG1xTGFXemduNEFSQmdxWlQybFVGYmRuTHNoVXFFaG5DcGRSd0pJQ05T?=
 =?utf-8?B?ZGN1ckE5WWtGQXZxSkpqTWwvTkJ6WWVhL0d6V3lYWDhFakVOYkc5dVh2QWtn?=
 =?utf-8?B?QnpEdWR0UnRiNDZQMlZhRk5oRVlOeGVDSll1S2xZdnoyUlUwVCszMDc3SzMr?=
 =?utf-8?B?V1lzVnMrZWYrZFFqSzZEMGgwZ3BhbmVRUnN2cm1tVDJiWGNPK05oWVQ4aUhF?=
 =?utf-8?B?ejVxRWxVaURJUXpualB4VS9Mb2p3eml6NDZtbVh0UlF6cHU0Ui9Jc2c3bVUy?=
 =?utf-8?B?WWxPUWhibFIrU2VTWHBucEdKQUR2cjhUNUpoaCtXdktwcXljcG93eUt1RTMz?=
 =?utf-8?B?eXcreUtPeExtV3ZSdWlOayt2UEZpY3A4VTNnNjErY002dFpLU2hXUmZ3djNT?=
 =?utf-8?B?SXZJWkE4K2o2YWtMTWlReUJhNlJCNTZOaHdCdTJUTmIraHdsWHZyclZROU92?=
 =?utf-8?B?enNxOG5KbWZHc2VUQXhKQ2Mwc1B1bGcxS0FyNVhYUEhQWlhRMDdaR2JDTXBE?=
 =?utf-8?B?Q05vUnpHc3BVeVBIeXowdS9veDRNWUlIdGx1ajJaZllZMWJyQjM5MWM4UGZ5?=
 =?utf-8?B?dEtER1NDV1VIaURMVzVpWTVVZFpDcWcxcVU5RnFnMTIza1pHaGRqejA5UWVw?=
 =?utf-8?B?bVdZaWdpMUJ3OGxZVklDZjhQVjVjOGZVSmk0anQ0c3RObS9hUEtyTWh1blVT?=
 =?utf-8?B?VDZCc2lxOVBjRURIYXVNVFpsMDViQ3o1OGt3NGhVTGtxSU1hMDJwMEF2VVor?=
 =?utf-8?B?RnBxYWQxcU1zb0sxLzNoQjFsWmQ1anF2T3d1SkdFWG5YT2Y3UkpIL2ozL2dT?=
 =?utf-8?B?OE5ucG5ZaDBtakt6ZFQxUk5VVkM3UUY2TGFFemFDNTRqcXg0YU82QTE2SzRG?=
 =?utf-8?B?SjJGTWJ0MmErN1BKNFNyTHBiQVZhdlAwUTlrSFBOQVVIKzhPYmlMT1RKRzcw?=
 =?utf-8?B?TEdwRU9wUExLa3Fud1h0QUpDMzkzN2NQNU1IdDZXc0ZPMUZVTW1na2lGMHFQ?=
 =?utf-8?B?bHd1V0R0KzJJclFFdDZqaVJ1dVNIby91MHFza2lxK0tRUGp2RlJtczZxcElD?=
 =?utf-8?B?REpYY3pFditScTVZdlo1Q2xoNnE5OVkrMVRDRVdsUklTbldRcFY3c0FOU052?=
 =?utf-8?B?TXo2bU1NaTV2YnJBNnUxTWZIUlpVVmhDZjc0Z1VTSWcrV3ZVdU1iRmlnamNH?=
 =?utf-8?B?TmZDNVpFRHFZYUkvMTBFd2M1VklpQ0RLZFZscEduc2JPcU85UWpoemF2ejk1?=
 =?utf-8?B?WmtoREcwWHdDUnJXdzcwcHVGYzlOVGxmY0xYSkUrYlZKUFNrVUZLT3U5U1d3?=
 =?utf-8?B?ZmhBZ0FycWxqWG1NeHllcXVCdy9ZMm40c0NudHlBZDlIVGJGMyt6a3RqK1Zq?=
 =?utf-8?B?T1NqblJtYjJLQjQvRlZKWjEyVUVmbTcwYzlNMmg2UmlQazh5UGZiMUtNNVBx?=
 =?utf-8?B?VnhMQ2FKVlFqREZBVi8zN0xMUkp1cVVZVk4xenhucktjNzNIUkZ6TXJzR0k4?=
 =?utf-8?B?MmNOVmxWR2ZkZ0FYNTAxWFVHakZkQ01QQjlGTnpzOVM0UjZLckpTODVKVS9J?=
 =?utf-8?B?MitDTjU2RGZwWUhPQVNKNnFJek9naEpsNU0rc3V1RGRQcmd2QnhjR1pDdDFO?=
 =?utf-8?B?U2ZJUG55TEREYnB0VjRReEIveDg0UHRncUorRWNGeVZieE03MnJKWjZyVFM0?=
 =?utf-8?B?S0tUdjVxK3QxVnF4Vmp5TlAraFFkOGtCWVdkU3hjTlN6WExOZ3M0WkV4bzRS?=
 =?utf-8?B?Mk5YSVN3VXdyamd4UkEzRkdkeHlqeTkyTjZ3djVwUlNjeFpVVkVUdzY1YkNh?=
 =?utf-8?B?blBuZG9VWDIwSXE1aWg2K2ozZDlwRDlQdjNDZ1lLL09TbFhadkVhdDl5VUsw?=
 =?utf-8?B?UitIMzFpMml3WTZBVVZDRzRmVFZvWnYvZ3JHbVNJMUFLMXllOXM0blJRZUNI?=
 =?utf-8?B?dEZjU0xNTFFYZTd1V0RKV3FRL0xuVk4vSUhueGNLUTRiSEpkT3JZK3VBZXUx?=
 =?utf-8?B?b1VVdzZzbkdWTG5iM2dKRXNCSmI5V29Ja0FTbVp5Nnh6c0JZMDNtTG44NnJv?=
 =?utf-8?B?eWhoNmdwRE9nZkdYb21QTVBJT0NrejFNc04yTWxnajRnZDNISm91bjFNcWFS?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2b41c0-37cf-48d8-74da-08dade6f3565
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 07:37:24.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNc3sc3jerg9gD6uyYexgd6WIPVrjkSusWnRrxrbyhW/BLIx6lMW4Oe6QCJcCoPkaeoH8TU3bXhjztECeZfBFkSYGoVKw1nDE3yOrqcCvtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/12/2022 04.28, Linus Torvalds wrote:
> On Mon, Dec 12, 2022 at 4:34 AM Christian Brauner <brauner@kernel.org> wrote:
>>
>> This pull request converts all remaining places that still make use of non-type
>> safe idmapping helpers to rely on the new type safe vfs{g,u}id based helpers.
>> Afterwards it removes all the old non-type safe helpers.
> 
> So I've pulled this, but I'm not entirely happy about some of those
> crazy helpers.
> 
> In particular, the whole "ordering" helpers are really not something
> that should be used in general, I feel. I'm talking about
> vfsuid_gt_kuid() and friends - it's an entirely insane operation and
> makes no sense at all.
> 
> Yes, yes, I understand why they exist (those crazy IMA rules), but I
> feel that those functions *really* shouldn't be exposed to anybody
> else.
> 
> IOW, making those insane functions available in <linux/idmapping.h>
> really seems wrong to me. They are crazy special cases, and I think
> they should exist purely in that crazy ima_security file.

Yeah. Aside from assigning any semantics to < or > of [ug]ids, which is
something IMA apparently wants to do, taking the address of a static
inline in the first place is a code smell; that obviously forces the
compiler to emit a copy in the current TU. But the code compares stored
pointers to addresses of those static inlines, which would be completely
broken if this didn't happen to all be contained in a single TU. That's
quite subtle, and probably fowner_op would be better as an enum.

Rasmus

