Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 789E016BF5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgBYLLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 06:11:39 -0500
Received: from mout.web.de ([217.72.192.78]:59527 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbgBYLLj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582629025;
        bh=D2XHRvOFPR9WzZoqGxrex+WWhHl9ZTf9IK53kE+n8Y8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=T8u6NHzYxSvNCz2m+WAQnq7p/qDqMcEO3J8/n8+VtF4DdG0F8MgCLuBjERDQXGcg5
         25XM/oJfZM+L4jSRL6aL2L8//eW6TtEGD6AMUSEWKCbIjARpPY/ppHrj0wCLeHsRkx
         zMr1t1Z8ota3E10J8faqj9ztxsk8y94J2nLlPqyM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.118.181]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8Qpi-1jKWWZ1JVC-00vuYF; Tue, 25
 Feb 2020 12:10:25 +0100
Subject: Re: [for-next][12/26] Documentation: bootconfig: Add a doc for
 extended boot config
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Bird <Tim.Bird@sony.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
References: <23e371ca-5df8-3ae3-c685-b01c07b55540@web.de>
 <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
 <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
 <20200221191637.e9eed4268ff607a98200628c@kernel.org>
 <5ade73b0-a3e8-e71a-3685-6485f37ac8b7@web.de>
 <20200222131833.56a5be2d36033dc5a77a9f0b@kernel.org>
 <370e675a-598e-71db-8213-f5494b852a71@web.de>
 <20200223005615.79f308e2ca0717132bb2887b@kernel.org>
 <8cc7e621-c5e3-28fa-c789-0bb7c55d77d6@web.de>
 <20200224121302.5b730b519d550eb34da720a5@kernel.org>
 <25dd284f-6122-c01b-ef22-901c3e0bdf37@web.de>
 <20200225154903.f636acde809a304bfccf4995@kernel.org>
 <8c99a63b-b1b9-a1ba-fa2a-38d1573f18b1@web.de>
 <20200225192951.b7753d3cf31fda2dcaa12fdb@kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d13c63f5-35f6-129b-a3b8-61cb9ae5369d@web.de>
Date:   Tue, 25 Feb 2020 12:10:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225192951.b7753d3cf31fda2dcaa12fdb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/5Tt/uCj3wyA7n5TFQ3cI0ASAyi3YXld41xrivpNXRAt0WK/h85
 BuEOEvagGLAncVD2m+vwnz3BNDnmNuXbRkNP8aveEaIPmPNScZG9H+xK818yF6N6EqzcPq7
 dGkjggsris44/eLBdGbwyCv4xzj6QEnN77dOwtEu5nzWkFyo9flMcwPC26QI6KThweQj63b
 iWRkSZem5np5P8UEciOww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ajs7gP3mvH8=:S2TfbiCeTwAVXvhy+Eacgh
 dGMOFxIrig23kDF/Q0TZ2U/8UPNHbTIaUIpLpflJXcrt9oC/P5jVwqwX+/OtX01GSMJNonLTK
 3C4LiS5z8M9wu+Dhx+ig4K0Uin5HtwXe7fo7ssAMuYtutwmP2Uex/HgnI5SC9OOfH3R2mI75G
 5Ve+W5ODTEgUizrq0l6pHtbfotu+M5DgUBa07hySXy99IYH8O0NwYvllGsqjwCrJOqfwfRq1A
 hBmI032RWRh3nKDDoJDt4yfg5HPOSSy43COIn0I6sDhy4B0SDxqFyELRB5qLB13IX1vJaU7pO
 wJuLwXkdFX2+RR62Lyohsntf/RY1Kz0Z+bsvNLqsHi2XrEwHCfWqyTFAG21ONQC5ydmpRmwCa
 OR4Uyp9nOT8NMCYUVksl09kyNLxYTW0wGjRjJoIa7H3SfmUwQiVaf4tKn1RfWQq+Ztu6f8YqZ
 zmBPPMGqsyxRMh0E8jW6vTqgfMaHP1I+F4S5ZbOQvqz1qGs3yf2afshvv76Z2RgHyrBh6sEX3
 FO/979rAczXb6CnPz2kB7X1DFSRRQn3+LQNobuscxtPsPGmRIDUF/w8C5qg+St8Ytgv2P2j0U
 baJlf37KpdBNr4K0S6xp9lAkndvXhMOhdGdVGL8N2+N1oiqP+/N1+Cz2Xvv5Y2e9AkuPltQB5
 TtIevgTowd5X9Jngj9qog6GcrrcinN8BPIIhc/TadmVIiS0dXfJ+ySZ0H0xzlryD80HDlHjEB
 Pd7kDmvRKWSEBf8B1omkL/XP6JmWguIoSu3vqMlXHrsh0Paf/QEvQfT4mdxlwrMykqV65SsPY
 6WRJubmkWBp5HYCKoFnyw2IXYB8jpKhGZJEhbuxmpFk5InRLH7vjQdADf8mm7AAa3N8riOwtR
 Y27BTHysaat7Rqs5x7hSAFNyqRBsmrl+p36qp85GXcrrEZAS5xldJSeNpTAOAsLZL0BaPcybh
 OwqA0pZd9mnIO6lvJFk+k2F7BAKt6fL0A46RivlCebLijRQAn97wbIRtjj/AwnxBlAV/PGy9W
 nz5REDfkh7jRRVGsI77SAWWhYhYTznTg+LAwQkvtdumPeKyrMxtmkw596GI/60bYxgiJK0fnJ
 aZ0d3XKRuGaVcFgXaJLCzrR6vkQQYTMXzt/Ni71K2wOEkbALbRh6EoGr9iB+5l32ZetvUcrJk
 gQWd6hE83BhheleN/jVPThguYTxpZqclpMQoXiejOI8nXji1kq4UfhoidmddEVun0u5rauRXT
 OSIG0eCJ6GHGeUVF/
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> The file format will trigger specific parsing efforts.
>
> Maybe. If someone is interested in expanding their command, (e.g. vim)
> they can use EBNF to understand syntax,

I hope so.


> or directly reuse lib/bootconfig.c which provides a compact parser. :)

I see some development challenges according to this design direction.
This software component is using programming interfaces from
the Linux kernel, isn't it?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/l=
ib/bootconfig.c?id=3Dc99b17ac03994525092fd66bed14b4a0c82f0b4d#n9

I guess that other approaches should be considered for the desired
software reuse in this system configuration area.

Is there a need to map key and value combinations directly to files
(and directories) for a more convenient data processing by user-space proc=
esses?

Regards,
Markus
