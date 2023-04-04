Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073FC6D6CC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 21:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjDDTAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 15:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjDDTAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:00:01 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11095D2
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 11:59:36 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54606036bb3so468069047b3.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Apr 2023 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680634775; x=1683226775;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXO/sPKYiSh7df3RL6T1nFQFdO3JNbaBjCjcp7Ezoio=;
        b=ZxnTqbt+6n8xVZ2L1KjX6Vxemx3sc/bCFzGlsXD8i/h258Tut+QudOL21vMWxdtnLv
         PQ0I0a7b3ybZfO5OzC5BDRoiSUbomrKlPxEchuya/pbPJNQRohpQVcA2xPlqQfxJiGVg
         qw7v6JjzcUXXPK5MexwHW0fGxt37thpVYrE0sUdEynyLqygCupwHmp/It8ILmvwvOES8
         vFM2dzIwzF6C81f7LiYJfI/FdIVoV+0uo3H3Q8fzHDaHt8JCeFL+H1iwqcEw+TzGZIXA
         zAi1q3zUv1q5qqh7YKu4FvQ/rvnAgETdBqXw1bZafgcS6l7EecmXZGT6VWTiEKl1JL0M
         skwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680634775; x=1683226775;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXO/sPKYiSh7df3RL6T1nFQFdO3JNbaBjCjcp7Ezoio=;
        b=zdCWXnx9OdjhgVnicYLfmLqR+BoQaN0ee2uDCmAXIKoOPkQ9H/rbkn+nNB6a0CH2Ey
         abBUR/h9DIVFLjoA9XbNfMuqLnQhrFHckJegVWyYZLRxNThmmdP4BYKPkTPPUpGCjDzP
         cxiabZfash/FJ/0D7BMGqMztS8CUEdwHz9J7NnR8wY55BmwjWDMFgQ7WkC/XMg4loZmq
         zoDxEnpem+5dJC0Oh/rFCS5asX50eKg8aNpq0Epm5kg72rd0L60aMg864mMp+sf1dEBT
         0HIR+abVyYETeQ0iJQmphBIoXeeqW7oM6YiY9S19Qgvfs1VSECM1UpsI58yX4IHecFBN
         MRYw==
X-Gm-Message-State: AAQBX9cOff6OylqAxmZ2YNQksumFzs+2j68g/IUya8dYr4Ytw33Hftr+
        kPJJGf2fqhbgrylhm1F1V0lihw==
X-Google-Smtp-Source: AKy350akuu8WNjqJI/OZZxOT3oKDvAK+k25HVUtFYCx5qfBTo1XdxOnKMEZfhrxaZAxyhBMpnNhZ4Q==
X-Received: by 2002:a0d:d857:0:b0:541:826c:20fd with SMTP id a84-20020a0dd857000000b00541826c20fdmr3545786ywe.13.1680634775128;
        Tue, 04 Apr 2023 11:59:35 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id df18-20020a05690c0f9200b0054643d99e21sm3390137ywb.133.2023.04.04.11.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2023 11:59:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes
 for CXL
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <ZCgMlc63gnhHgwuD@memverge.com>
Date:   Tue, 4 Apr 2023 11:59:22 -0700
Cc:     Adam Manzanares <a.manzanares@samsung.com>,
        Mike Rapoport <rppt@kernel.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "seungjun.ha@samsung.com" <seungjun.ha@samsung.com>,
        "wj28.lee@samsung.com" <wj28.lee@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0C2ADD0-35C4-4BE4-9330-A81D7326A588@bytedance.com>
References: <ZB/yb9n6e/eNtNsf@kernel.org>
 <CGME20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8@epcas2p2.samsung.com>
 <20230331114525.400375-1-ks0204.kim@samsung.com>
 <ZCvgTA5uk/HcyMAk@kernel.org> <20230404175754.GA633356@bgt-140510-bm01>
 <ZCgMlc63gnhHgwuD@memverge.com>
To:     Gregory Price <gregory.price@memverge.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 1, 2023, at 3:51 AM, Gregory Price <gregory.price@memverge.com> =
wrote:
>=20
> On Tue, Apr 04, 2023 at 05:58:05PM +0000, Adam Manzanares wrote:
>> On Tue, Apr 04, 2023 at 11:31:08AM +0300, Mike Rapoport wrote:
>>>=20
>>> The point of zswap IIUC is to have small and fast swap device and
>>> compression is required to better utilize DRAM capacity at expense =
of CPU
>>> time.
>>>=20
>>> Presuming CXL memory will have larger capacity than DRAM, why not =
skip the
>>> compression and use CXL as a swap device directly?
>>=20
>> I like to shy away from saying CXL memory should be used for swap. I =
see a=20
>> swap device as storing pages in a manner that is no longer directly =
addressable
>> by the cpu.=20
>>=20
>> Migrating pages to a CXL device is a reasonable approach and I =
believe we
>> have the ability to do this in the page reclaim code.=20
>>=20
>=20
> The argument is "why do you need swap if memory itself is elastic", =
and
> I think there are open questions about how performant using large
> amounts of high-latency memory is.
>=20
> Think 1us-1.5us+ cross-rack attached memory.
>=20
> Does it make sense to use that as CPU-addressible and migrate it on
> first use?  Isn't that just swap with more steps?  What happens if we
> just use it as swap, is the performance all that different?
>=20
> I think there's a reasonable argument for exploring the idea at the
> higher ends of the latency spectrum.  And the simplicity of using an
> existing system (swap) to implement a form of proto-tiering is rather
> attractive in my opinion.
>=20

I think the problem with swap that we need to take into account the =
additional
latency of swap-in/swap-out logic. I assume that this logic is expensive =
enough.
And if we considering the huge graph, for example, I am afraid the =
swap-in/swap-out
logic could be expensive. So, the question here is about use-case. Which =
use-case could
have benefits to employ the swap as a big space of high-latency memory? =
I see your point
that such swap could be faster than persistent storage. But which =
use-case can be happy
user of this space of high-latency memory?

Thanks,
Slava.

