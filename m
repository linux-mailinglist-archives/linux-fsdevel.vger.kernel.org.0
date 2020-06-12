Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE611F7CD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 20:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFLSWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 14:22:54 -0400
Received: from mout.web.de ([212.227.17.12]:41575 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLSWx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 14:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591986164;
        bh=oZ9Mc3ST9ncu6DM1NtTvyeE8DFU4qiuTtexUmhhSJ7M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Bekb71KX9Bc2HaCHFlOnWve787lz2l1rIS3joejfyAHvz5uoXzpDMqhyhrMSkhFdw
         iYkvQ0yVC9i4h4GQSnjGRonwplIob7s4dNbbuqNEYBjgjmqmQeNDvU6Dl9pms0kDle
         29P/TXGQ2jwNjLMZYylMo1Bb2A8TtV8VlDOlHNZw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.95.40]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXHOz-1jOc892d3l-00WIKe; Fri, 12
 Jun 2020 20:22:44 +0200
Subject: Re: [v2] proc/fd: Remove unnecessary variable initialisations in
 seq_show()
To:     Matthew Wilcox <willy@infradead.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
 <20200612170431.GG8681@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
Date:   Fri, 12 Jun 2020 20:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612170431.GG8681@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i5lv1WtzxvmHkVDXaJrM2NOByWVNyhzOYHkAhPiIXTS4j3hTd6Y
 YlmJRJRVJTTH+0kwD78kW/4I8M3m7iYnCd8brFzT38otlwS9wbpV5uj6n4WwyegdMlsp+uR
 rhXsOHuN7xTP3ah1H/C0ylBBYcZpoVdyYsT5Hw5MgnZ2cdaer/8GDO99p1WJA0qqPTmklF/
 ziV/UjvhdzvlwonhbyEtw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bccVSjPBz3Q=:6/mmCN4zeV0USBY1yUDDvw
 H6bL3UWikZfnEqJsYGiSlpwcIRkMSmxSnkLkb//9cXsD1ywA8Dn4AQh/OgFh0LS3g9c82H+AY
 /a3xa4sLTXUmMMwGFAhlo3MOn9in/y3hxPSo4el4ak1OjYZPFAEmvFbWtZkb/OBY1vJe9clju
 HnXvXm4xQOmjNjfiYdHCsZYT5r11m+JhucuBFIHEi61OVnHfe/Eztu6eTt065K3KtkiusUJQj
 pa/kODeJ00EQ5LraKx4Z7Qr31XFQhKVgy6PFfVkM+PWMPx4ysyDNu4BNTez+ziQTkS2heIdHK
 WDwxn2QTCosNIqYTzk1XWPlT75tUSfA1wJBpz/rVuISyl5apWZM2t1m4b/teGYKuAhC3/9Oes
 2Rxn79KwBXYoNDVmMNoHjlvHIwh0EjqTPSGRAeHfnyNNDC7VK8xMuSO5PH0FsBZNR1At0ZLfw
 0B6DV8qjfZzUe5/5r1TBdvQsKRuSEYufM3aaAY5yWjfZ2vsUUiJTSa3iphpsOnnWc0KDfvOEm
 M0OJf9OuQNb7STCwGlk8Mvqw2gRCmS5CtC3vEN+EP5h0HOjB8hX9SqsX+aauMw9PjlxfBc8Ol
 TeFPHTOjTqIXa5PTMCneCoiwb/NoeSEMG2DCD/514EP9I69u0VVYfQjC0pAN+yJwIMNGvDbqH
 HmwIWL0hyWzd477KGfooaGZZTT5o41R1j4Pdzpiyq9B7J2lBFJQ4ihQtWuPYJF8AbIGj3BST3
 A5LN/THDyI3wlBJIlMu4Ix5hMxnz+T/gjIIoXheXYPTkednDLkwLBL6ocYXCxZg7aecVgi2fr
 uDnz/onSXmsCUvi1E81Tsk1n5GfLVd2BLBr/K/dZ6mf/Bad1VSn/WSimKDABulSP8wGuAeV0k
 tfflz1aQC3L72h3m3zWc3QJDu9H8q4BnGYwL1oZ3fguYvv6hd/+G6QKnC7/rvlUrVNtbZoBJX
 JBB+vcNmL9R69hPBZ1UfzWf9L/UICebO/0/EzK3yBDIZYr/IGTkpVOyTUhtb8wo6R5RQAVFtg
 WCZQIDeo3aTpJKf6vJ2lU//XHXAQVji1VC2BynIp+i4sGUPbCWKDS5yZ1LFbvXX0V3nmSAXh8
 aJDnVq767oinjM6QP/QVnNsMNjvk3DJIGkjz99nX6L99YTxXsXzOwN4RuygJwmk/Gs/ccZ5qn
 kf8lX7H6w1OnImrJgCvH8N+vKXrFRNwZhtCGkY/ft/Tl5sTF30qfXBYlpIhCgqRvne5+oATOp
 fH5AiNil5Rl1Gcxaw
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Would you like to clarify concrete software development ideas?
>
> Yes.  Learn something deeply, then your opinion will have value.

The presented suggestions trigger different views by involved contributors=
.
In which directions can the desired clarification evolve?

How do you think about further function design alternatives?

Regards,
Markus
