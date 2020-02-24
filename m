Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE32C16A36E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 11:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgBXKBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 05:01:45 -0500
Received: from mout.web.de ([212.227.15.3]:59049 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBXKBo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582538441;
        bh=a1FzcZdNoJz2yRNqSLPltbQAqbseQ09MWi49GfTrFB4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KEpq3PEE7c3EGqZuVGPZqjvcv5pzhjWh2jzqBWhBlrf43Bb8D1XFrUw/bVnSRIJ1d
         8wz1d9FX6Qu4jlHK0BCiFJI0MlQvhbbgJDCyAhWKLGk43z+5Fw5357wQSyXVWaw3QO
         wZbka1v25jETjrMXL+3vdZARpsJyERRLBUboljwQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.136.174]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LzEO1-1jRqEj353x-014Ss2; Mon, 24
 Feb 2020 11:00:40 +0100
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
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <25dd284f-6122-c01b-ef22-901c3e0bdf37@web.de>
Date:   Mon, 24 Feb 2020 11:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224121302.5b730b519d550eb34da720a5@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:U2oSjIFNsDYhf5uDHf9gg7EjjOFoQsJASZJ2OUbYvL2zq6a63oS
 CTmLrZKZESLhxV2TyKbXtaNj7JiuF5stQ8P7nliNrkLwUpr2+qaM9roYooR7sOOHxbyZAyV
 1tGIzSZQWThlMcs5bihplPaIOON5cU+Dr2H833OrcHcxEhY7FsdQjjfsaIt5EQaH6lz7m8k
 KAPxcB02/SxXHGTZbVJjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7K7pkjagM4s=:Zb/hmyWVTTi88UbVK4OqHs
 f3rXjBc2PyGqEeMa+ItgHnPRvIzYCar0ljx9FhV8OBnN9UMlLrhuUu6IFZKHEQoskRLuvM6eq
 6qgZyfhbDvVAEgj2uJq4mRB91oZdMFoI/vM3r+aGVGGGi6hF92lyF2dqKuvirDbMOGgLfWvt8
 4SCEdeGoksW2dJ/MLdUDgt0u5EtZDW4XT4dU8kTaoKh8R4aoNb3a6DU6O9dQaBlnEKW9aczoi
 MQPDyBLKUn7gJYvHLq3yR2lcYHQgCJXJhLG6fP2k95BE37i3GfAnp0jsEFDAk3Cya4gtUPvEn
 o0ewpzmX8IFAyaLb31xC9tILgHZ3kNhz8CxE0/KHAOwxaoO0990u3/eLow0EyBywXe3jbEr/f
 lbk6OnS11mGWGH/mmRtBEm79qYyoLRod0WwaJ2EH6EzDYVBgyEArx2JPQBE9h2Ty8dF0Sdduj
 blgBKWixx5CiSnelNLN8S/BeBBqhz09Ccw/da+U/cL5nBeBLqmvFQUVzzdl0iuwaDxqi5S5vU
 yFaf/6cDKl4hYipt2/CJOXl7hdSulUPem1mdSmPoIqR918HT8A++YI6ah09lAEw/v9G0yiP7Q
 gR4i4BCX7lVQiYPCcVVD2Nq1iVmajHho3G99X6nVYi+giwX0P5GUR8uaK+kEWgHfrzh/z3i26
 +jI4SsxdhYR4uBAzQ2S0OQec1z5Xe4nQC+jihc1m2rCdh3ysR4otNDcC1A9w1zG78KAz9dl7b
 4UiTElcDPEYcvELfEqZSF87+W+bAAGeO0LTu+mxlmN0ejzw9fnWmpt7yuZHOnOImVw5g1O5ut
 whw6GQoF2uOglGJpJIw0q0DMfxZn5yOh9IVTSH2wDA5nS3TWBUnl2DHq2S8uSXDv8J5jHTdp1
 BsRh0EG1reG3WeAQDHwX7Lkz8Njp4r/toraViWqMbb6pALLSU9GzCn6wTItUSUxPcEhloUTFi
 RsrzXoBizp8GUyWoeIwVFotkMvMlBzG9m6/uuHIXBL2elQKPhd1t0+ONLAjrVzGjuZFWX8B9R
 jM2UqzWjYvm4GDj4SmFQ4L6gchNU+h+uf8U76f+gv3reLWojLKqzgWMzmlPFyCfDYvB6ygNVx
 +HInpbiRSDNUuaE8mKfmGfpM+5L5ewzXCZC3pWG1cXHmoXiz10E/0i7kS3a4wBSGrhDtlSJOU
 1GJw/FwK2QuXVUgj3dkYsrxU4bXKpfUzw3pXudti8TCwPy38s7d0gq1T+kTei7gzQ7GODCwS/
 reZj8SZKTpM4oOOkp
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> OK, I'll try to make a split EBNF file and include it.

Thanks for your positive feedback.


How do you think about to clarify any additional software design options
around involved data structures?

Regards,
Markus
