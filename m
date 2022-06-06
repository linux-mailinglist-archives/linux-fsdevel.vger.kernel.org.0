Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0361B53E9B2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiFFPNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240273AbiFFPNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:13:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD53FBDF;
        Mon,  6 Jun 2022 08:13:40 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 255JL2Bq013232;
        Mon, 6 Jun 2022 08:13:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=odgPkFKtWmNipPMAVEpLfxAuxvN+5RIcEJaDWQSUjSM=;
 b=LkbBhBqnwmSw+pYhbfEjHkiAOVOrG9t2UjmEADcZzRtQp+jdqyteIPcLTC3zbI+McPBe
 6X4WAeIT3kdv0nfPkgH7h/nvhoYruv1AV8+dwewR+j+4j/QaHzLksq1kXwvnYFvfAzPK
 oCZxO1JeNq9tpgO79JfrcB+euIAXjxYt0/s= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gg2qkh0rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 08:13:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geqT8eGy+DRPIatVLvcZZuxPVCjp7IVksYWKwAx5Kb+0QfaPMW7jqFQoAGjDIO/RCzHnp/oPugR7HVkVLeruuZwxGqLpqSrtlcdySef7E1yIDtTUT+M5tSujBmoWIPPdwCQWlJguvFHN9c1uYucA3nUQTk4n7bRj7vw9I0c+ERvAQRoeI52eq6YO+fQKqpoIA4bMTQKQUblAvaU+xCzDOwN+EAy8t9Bx4VTEzZOXy90RW6PBVZuMRarosy6fOZQqW4N2d21ED7nYJ6DO6N84i4ghRZstwKT+TQn47RreEUSKuJtgHbLB/AYTOL054TDPXLwS8fN/BPZ9F//AaXZgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odgPkFKtWmNipPMAVEpLfxAuxvN+5RIcEJaDWQSUjSM=;
 b=ipFS+MGTyEnLYa0BCJrUcnv7xV/S+oVg5Xi21K1kxebaihQi0VHoWzpvOtjpVN5FrP1cHlF2iCq6/lFM6H1T0dRtaimGeZW0no1TlXmB4C3txGNETrnFElRxcgz/8NsfYE68H2IXOuTNAHMrDtIJfMyWDEwwAvbaCY7lbkiMm/K/tE16kbhbsfGgpet/RjEQSrYVcL96XETsYFPeAYgIlqJEy5meHul3fHhgice7y3g+eLOmKys1N6c1EhrgAcS+ChS5i9L7BfzLV38lSssgbbfz+09Cpqy4WkxsTsHpok/eQt9UZjGAMUa19oFvO6bEJfjjWnW5O81L2//zllNwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by BLAPR15MB3796.namprd15.prod.outlook.com (2603:10b6:208:254::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 15:13:20 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::548f:cce1:5c99:3995%7]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 15:13:20 +0000
Message-ID: <da9984a7-a3f1-8a62-f2ca-f8f6d4321e80@fb.com>
Date:   Mon, 6 Jun 2022 11:13:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH RFC] iomap: invalidate pages past eof in
 iomap_do_writepage()
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "dchinner@redhat.com" <dchinner@redhat.com>
References: <YpdZKbrtXJJ9mWL7@infradead.org>
 <BB5F778F-BFE5-4CC9-94DE-3118C60E13B6@fb.com>
 <20220602065252.GD1098723@dread.disaster.area> <YpjYDjeR2Wpx3ImB@cmpxchg.org>
 <20220602220625.GG1098723@dread.disaster.area>
 <B186E2FB-BCAF-4019-9DFF-9FF05BAC557E@fb.com>
 <20220603052047.GJ1098723@dread.disaster.area> <YpojbvB/+wPqHT8y@cmpxchg.org>
 <c3620e1f-91c5-777c-4193-2478c69a033c@fb.com>
 <20220605233213.GN1098723@dread.disaster.area> <Yp4TWwLrNM1Lhwq3@cmpxchg.org>
From:   Chris Mason <clm@fb.com>
In-Reply-To: <Yp4TWwLrNM1Lhwq3@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:23a::26) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17bb462b-f8a2-47cb-701f-08da47cf1776
X-MS-TrafficTypeDiagnostic: BLAPR15MB3796:EE_
X-Microsoft-Antispam-PRVS: <BLAPR15MB37965A5739A86F840AE20745D3A29@BLAPR15MB3796.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVwrzgYrPSJvpg/vW+ifNbYfZaDxtNLzgMCJ2Q/6OggncZeUpd/lkIHHsOI+3x36KvZPcpxzPldx4AeVTilTs6W/dOvBFPU082bz0O70uyEj8uON0frF9EtPjPUISDmuxhujPMKwg4KSobUF3MqWZm+t0E4uw6QaMMPIS0CucVosaRJfciYbFIJW3Px+1e4LAFotSGy6w7YTyWLSA87Di8Dgz9cQaA0KfyjQYN9T5Q6LCSJuQVBfmB8rHOUkXexhsiUWMX9haZQ46b58bj/RLuWkZ2gxKLgMZU2qUmaFJGpYY1ouggbK7EPIG54CpngdycukPrbB5g3Gx+CVIVohFF6K4z2vct1fATcgG0u5C3nVr0gQHlcxN7Hb4WfwY8DpyMTNtWUC451opWUIoN/0WuegGFJs3cxPfO8OKCbh6o9+naOmkLbvytbaAkpV7pAogJlr6SC53ykdsUVM3rSFa80AS1X3BQ8tOT5Ed8UBTZwNv47nLDNNKhyvcq0u+aq8DgifNUnEwvrs/chsye5UCZSnJpd/lA6LWtkL7nX038uf1Zi3quvkyUD2v/UgY0MEsoXdkeBAWA92t/3cH9nAPqkg9g/ytClSzaNllCeqEsMZdofnNkQmkAVAM+DTmgNCrPwQa6lw2iHMKAtT9tyFJjSTCQ3d18BKEV2adaCK6aMxuZwKwPgUadLdXWLUGXDdw6vOusgqoI0aaiAbLaAyssYRDSt2KR9M+b8RGOlZGpmCPsONr+WXeTet0wsC0Qme
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(8936002)(6506007)(83380400001)(53546011)(4326008)(8676002)(508600001)(38100700002)(31696002)(6486002)(186003)(2616005)(86362001)(110136005)(36756003)(66556008)(54906003)(31686004)(6512007)(316002)(5660300002)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0drVGZFU2Y1TG84NWtzUlRUWXJJN3piL0tkeW5VRS9SR09ObU9iWHpOaFRH?=
 =?utf-8?B?SHNjSW1LaGRsNDNVVEY1YkpsV0JnOU1JWkRqbVlMZDl5MzB3SlFWRThwcVVt?=
 =?utf-8?B?MFBWUTdINXhYQmtESll1NWVwSHI5bXRDUTBSOWcwTnVHckNlQW4zeFVQZ08y?=
 =?utf-8?B?TXJlL3F1alpKazRlU29lbnFSaDlabENlc3M5VW9BOU1mQ3Z3VUU5bUtYRU5H?=
 =?utf-8?B?M1Jlc2hPTmF3T0hXUEorMXpvdEVyRWNrdkdKb255OWIwVFNrSlJMTFMxZGZZ?=
 =?utf-8?B?clpXb2xnVSt6bTU1WWxJeFVHQW5iL1F1RnVoWXd6RFpFVldwM0Y3K2pQandZ?=
 =?utf-8?B?TlZpTHZwSzFGdkg3ZjVLN0IvT0dXRS90R2szcW1MY2lhNHhKenp6VkJuaFdP?=
 =?utf-8?B?cEpLOEpGSmdLMXVtUnRxNXA1aysvOTRUbFhUa0hBRzhucjlwSzh0aXFKU09M?=
 =?utf-8?B?UHVKWmovZ0d1WXFMZjJYRmJyU2FTdlc2MkEyZVh1S0xlVVRLcTRhSGZSTlMy?=
 =?utf-8?B?YStENUg5QXhkU3lkRzdYSkIvdUpwNklkNGVuN2RORDE3aXRyNFJxRUVWQVZo?=
 =?utf-8?B?ZGtIb2xoM0NyTkVvRGp3Ynhla1RmRzJ6Z0h1YnB4aUJWbTI3UUNNV3Izbzd2?=
 =?utf-8?B?eElWM1MrQ21hNjJSWWZxRmJrc0hXZTVTL1lqSnlvUSs5MVRBVlhQc3pMWkpO?=
 =?utf-8?B?ekFrdjY2K0xmbFpjK29HRjA0bzl3RWx3MmwxUzJLbm10d0F4aEpLYnRCUmxN?=
 =?utf-8?B?bERTTmd3L3FpWEFQbE5wcWN0WlpUTW9LeXZsUGQycjU2N3dnUDJLTE5XS0JY?=
 =?utf-8?B?cWthUmlPY0ViWVd5LzBtSzdzM2xBL0dOMHdnaytHNy9oMGVMMkhjRktFOXJB?=
 =?utf-8?B?R1lIYTBGa0NvNGJuNHpRNkJxS1dFUEVIdlc5WnRDTjJnL3BaVThuVTJyK29l?=
 =?utf-8?B?dXRYejJxNURNamRJZzArT1Uxdys5NkZ6WHpGR3J2ZFU2cUFjSTJMY1NmSmZE?=
 =?utf-8?B?WkIwWUJpM1ExQ3lvVDF4L2MyN2c5R1NHa1JwbHhwSUljS0pwTEJ3MnIrUXVS?=
 =?utf-8?B?WVVRR1dGWkNLNUFzbi9mMVFJZzI0Z2Z5Q0dWTTJxRG1YeXF6R0lMK3lLdm5D?=
 =?utf-8?B?V0orQWhmZnQrMDJ1dXlqMXVXVWsvN21NVzVjOUVEVDBJN05Nb011L1BteVA1?=
 =?utf-8?B?VUtLZVM0TEU1ZlBIR1IxMW84SUMxVkEybnEvZ0hvVzBPNUt4NDdCRUU4K0tF?=
 =?utf-8?B?U0JFTjZvMTlqaHY0djM5WUxFamc3RWdORU9FS1ZScDFxdzFxNmRMN1V4Q0FD?=
 =?utf-8?B?cGRGOERMRmh3aG5EQTBKUFZrZElEb1RDUEpkQ29KbWZ0ZzdCd2YrMFA3ank4?=
 =?utf-8?B?cmFjbzFrOUZkSDQvVGIwNTdXMnJKV2hlSGVySFNqU0xOT1ViS3RiUHpsWVYy?=
 =?utf-8?B?bndhdENvQTFaS1F3bGFobHdQUFJLam5zak56bWZWdzBlU2s0U29EUkdUYUdj?=
 =?utf-8?B?VmhHRXgzb01Vb1daTys5djlUTWxqNnRJY3RQWGZaM1dFMWthVlJrMkNBWldh?=
 =?utf-8?B?djRoRUw1R3lQTlpaTU5SQTVCaTBDcGZEZ3pBb1BoMU9IenlLamxLMXZocVNR?=
 =?utf-8?B?bUNrUTk5T001eHVTaTlaaUEyaXlrOUd6QXo1T1gydFJtc1VUcTUzTjV4Umlk?=
 =?utf-8?B?eHdQSTFlYlpiWmdwVjZXaHhkcHEyRjZucEhzT1dDejRrNXhTdnRxUytGN0FT?=
 =?utf-8?B?WUNhaUlpQjBxRW9BSUc5QWN1WTRnZ2lvNm5RcDFzVjQ3bnZvYU1FNng2S2J0?=
 =?utf-8?B?L3ZLSjE2YS9LTFRwOEd2QkM2SE8vVjVlNDJCeGsvamVXUnJsTFpvOXdqR1Zi?=
 =?utf-8?B?WXMyRDhDZmJFMktPbXNoSCt5TTFGYi85QkVkZnB5RTlNV3NCSGdmMVo0QTdm?=
 =?utf-8?B?d1hlWjFZYmlGVVdhM2JsZkduRlA0Q3BuNzlxZTVrcUZhemxNUXMyWWdtOHB2?=
 =?utf-8?B?NnZ4cHNqc0R5KzlaYStkVlY4dEJyY01ob1ZYY3hKTEZZMnAvOTgvMnFrYSs3?=
 =?utf-8?B?ZjNXT0IwWXIyM2wrSExaZTNGaWFadzl3b01zV21wd1hFL0xDMEhXV3ZESjVv?=
 =?utf-8?B?WjZtL0ViZ3pSVDZGT0VnbEwrcFo0V2lKRVhLV2dNTXc5Q3RQM3RsdzZRTTky?=
 =?utf-8?B?c3VtQ0NpZUtPUXZDcFRPTlhRR2tvaGtNSHVYeFdNVUFyZWUyV0pVVTRpdyt2?=
 =?utf-8?B?d09oaFNFelJTYkE4TmpWOWl2NzBpS2ZmSmI5L1lDV2Fpa1c5aHZiZnFPOVR1?=
 =?utf-8?B?NVlGSXRuNkxJQnR6OWxObTJCRkhyQ0YvTWhvSlAzVHp1QnVaVXlPcVF3UWlW?=
 =?utf-8?Q?esv6otL0jmxWO0GQ=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bb462b-f8a2-47cb-701f-08da47cf1776
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 15:13:20.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcBILksrcTrD0INL+lwbWiUxNotOd2JR+g4NJzvbFGAh5ggneIGoKj/tl5Ox77qd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3796
X-Proofpoint-ORIG-GUID: DvvSHBcRfFMIz61Zy5pgYSiGzfsKql7T
X-Proofpoint-GUID: DvvSHBcRfFMIz61Zy5pgYSiGzfsKql7T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_04,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/22 10:46 AM, Johannes Weiner wrote:
> Hello,
> 
> On Mon, Jun 06, 2022 at 09:32:13AM +1000, Dave Chinner wrote:

>> Sure, but you've brought a problem we don't understand the root
>> cause of to my attention. I want to know what the root cause is so
>> that I can determine that there are no other unknown underlying
>> issues that are contributing to this issue.
> 
> It seems to me we're just not on the same page on what the reported
> bug is. From my POV, there currently isn't a missing piece in this
> puzzle. But Chris worked closer with the prod folks on this, so I'll
> leave it to him :)

The basic description of the investigation:

* Multiple hits per hour on per 100K machines, but almost impossible to 
catch across a single box.
* The debugging information from the long tail detector showed high IO 
and high CPU time.  (high CPU is relative here, these machines tend to 
be IO bound).
* Kernel stack analysis showed IO completion threads waiting for CPU.
* CPU profiling showed redirty_page_for_writepage() dominating.

 From here we made a relatively simple reproduction of the 
redirty_page_for_writepage() part of the problem.  It's a good fix in 
isolation, but we'll have to circle back to see how much of the long 
tail latency issue it solves.

We can livepatch it quickly, but filtering out the long tail latency 
hits for just this one bug is labor intensive, so it'll take a little 
bit of time to get good data.

I've got a v2 of the patch that drops the invalidate, doing a load test 
with fsx this morning and then getting a second xfstests baseline run to 
see if I've added new failures.

-chris
