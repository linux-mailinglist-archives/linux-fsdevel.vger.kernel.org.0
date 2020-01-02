Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A032A12E4E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2020 11:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgABKTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 05:19:53 -0500
Received: from mout.web.de ([212.227.15.3]:40045 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728036AbgABKTw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1577960378;
        bh=C0SDFD1iRngMA153Tb3Ivt07XLbnNjJQe2n8MoI2e48=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=Ied0+hRPgw8m455+DHiW6JC4r7YBZu6Qa3Jk1MXsflw7zDQnWa3f9pcXyyRGiAG6g
         lDnWg+xyhMV/taTp8oE1wH7xzT4gXL8SiVtRxotvtUrEKiDNpiKNpp6CvTeR6I1d6B
         Ht0edMto7QtHJBhE2XjWSRSly+THV6J6HrJsx0TQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.119.207]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmuQW-1jN9Ko13ls-00h3EI; Thu, 02
 Jan 2020 11:19:38 +0100
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <CAKYAXd8Ed18OYYrEgwpDZooNdmsKwFqakGhTyLUgjgfQK39NpQ@mail.gmail.com>
Subject: Re: [v8 08/13] exfat: add exfat cache
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <f253ed6a-3aae-b8df-04cf-7d5c0b3039f2@web.de>
Date:   Thu, 2 Jan 2020 11:19:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAKYAXd8Ed18OYYrEgwpDZooNdmsKwFqakGhTyLUgjgfQK39NpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Shs8ZPj6Fq3wgNTVCDef+zi2jbRsY4cfG2qt1sgeG6/ShedCShe
 zlcCWVNm0iyDIsxwQrQjosCR2lsIGE/qV3RcldV5ijmxL23a51B8E5CBJKHwbngYiA8Ilwk
 2RwkEIKbIrjnwh+LR0uZucFC3janQO4SdZ4OSa3UkXdeaYQcnqtmC5pZp8GnKaMWdNux9tU
 LW7PeaUNJhN2RMIOserwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1YvB8s7obBc=:rkzwGTU5pNOJZFA9vQaTbp
 J3Z1cdNvQlCJbuWRWtFk6iCwmJ6TsNDHfOiKIkvSU56tQjgN6PTzfu8XZwaqY3+NUW7s1/nhi
 wLrDYLIN5urAQDLxQ2WiMslguQTWql7ZsqozMi8zoRuyYFVVo+Li+m1vv5kb4szHlUFB2isrX
 BeWK1SV7Au0jyfC2lse2+0YWw25hPATFRv2b+Xg8ZbVBviZ110kkaBXEh77JKise3g77UtDbU
 SX5AE6PnLllGo+z9uDu1CKrGcdkQlgWr6WzBBrfwTvs+Vy6Zz3dPiPkTHlvgDkLzNbwkfWx2Z
 SH+h7tvzBl8J19DNXbBUb/h7Zx806nrdAP85vrszyHcWSG4hKnlzQ5Lx64ncGzSEK70XqAVXz
 ggf9a9j/LDqrJsSL8zRLOg4w+vxlQDe99Rgw/jcUuxkCanDFZ6Ohs32OLKCUGpZ/ZVB6DyKMO
 GBNDKBWToLyD53qbwgOEQlo5I7G68ZZGtFDtY7lJYHEcMG50i9Rf4kDYOcS99zIvHvs8+/WCm
 3OmEK/3tg83voSzbjKGpIJL6g/q+bmXTmMjZqRIs1tPg1HkS4gxnJyBHsM77DMt9v//lMYl9+
 DwnQ8s+CfgxKOjyZCUm7Dbqy+bvMc0IvCjLjtl96CWn94XQ2soV2t0Z0xI7avlQimA+U5obIu
 vcQ/E0HgOf72OAI3EI7rU85z+Tdo1UnzS/aLrRGZdsIGF5CQ0kDm0dytJA7CqvD87EypWZxuK
 sM2DC/kffbuItROtf6hS/egkvBfEDUaCGNkv1NfvQP7w8xBTFirWDhFTX6tC5qSVPejd12jzT
 i70y1gGpK/lKQL1IpD6etBYWrJbAdKuh0avvcvnZeFan4K0n15aLo8ZreBMfQwPMxutNgXFRH
 DNZJQ03hke72OiWSb8vGgZgx1EJ9h8DjC/Z98mzkHPzgyz6y3MnlO32irdklLuY92+B0mBnrR
 WR6zk6xAom9kHbAG0u5hMllP1px7wsakEvXzpNYZEi2eL5jba0kFLh9Nah9O5VeZp738Nkgj6
 80tXtNqTcO88IvPa9xIS4xjsUkSd54kt7DGq1W1oXwb2qTjJph36d8vIl6yH8iJUMTZoG4rDb
 UpW/u9IqXaOIzyKwEVtJSP2ql45oTL3oKVv4wvPj/hWzmJ3XyDfmqsZYaCQstVlbvxBKk4QWo
 ExJEeXZQou7cNl4xV+SgLS0PMfCfJKyXQ7+gWgYOCHNxkof6T88sJnOMFpTF2TjZQBiHyW3uw
 PffxJjwDrQPwmvuTF8991cLmP9D8xrZ4beUxLi1PVbJSy9TqC7nSey0TQUU0=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I am planning to change to share stuff included cache with fat after
> exfat upstream.

Can unwanted code duplication be avoided before?

Regards,
Markus
