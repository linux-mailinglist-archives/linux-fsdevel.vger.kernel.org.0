Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6603A4607E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 16:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfFNOUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 10:20:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbfFNOUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:20:11 -0400
Received: from [192.168.1.110] ([77.4.92.40]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MS1G7-1i3agl3c7v-00TTps; Fri, 14 Jun 2019 16:20:08 +0200
Subject: Re: Help with reviewing dosfstools patches
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190614102513.4uwsu2wkigg3pimq@pali>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
Date:   Fri, 14 Jun 2019 16:20:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190614102513.4uwsu2wkigg3pimq@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2LLNQoGhbONM7cyzksFdRnDRrWxFja1lcyXQZkHp6CWWemZOkKF
 pc3fUTvjvOWenMaUP08jTJaD4bFmIqeyEpnapbLFd+NB5wEGkJnc1wiR5RbM0n1wrJ1Atsn
 8sUteMyz4dUAuL11lg6U6vOe/AAZZpsjzILFkfAaNlF2EkcYP041m/+du6ucu1QI8wSz/QA
 pbZU69Ng0PVKjkhBm4lZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aQchCXy9btw=:9Qws8XsyQdvFbXHq9LjVfm
 GzRTHRtG+vO9hkB8LN9NLXAiEbsmpSpPglc34dCBVvRiQ+FuxwHxWsXcdJ78KV/Cq7gUia/ym
 ZR1BcplPcOlPbB/wc7goEdiypd9Y4m7lHO/lUzRl2ToJZ/6+0udruO91lh3tpnnRRTxiM2yqR
 9NsQW3aSJ4lKZItnGYyCEDI1CWTb1DvHanEzPFKVTRNA7cmzJc/tgZUyR9XSr3fC239eRzZHY
 sbAfC8WcGu4iiMFz1OY0t4TWbhjEYer9n+tFO+3Mjg0+tOvJxVlbEDU0Ak0ZIAd2IdH+k4CcR
 xC8ksBUf6ptFcGfkYFAVCNiO83RTZkLsv8VOHcW41PhG06VB0ux6ZI4GXwnjPktGMZneS18VC
 zckfodNus0nc6r1li4t8cx7XhA0cIdn3PvTWAkdailUvk2rcVX3B9N0Q3mNqkhringMkwWMUV
 5r3Emo8SsoJXESmTaMSBWWWFgrskjbEIEBlHQsQsgJywpsyI94pxRoUexuEMjxiJbrbUQFjNh
 oumJwpQ2j8o4CDp8Pr4WdbRfWekD/Xoh0pwznRmBF2eaLZ43PzrWMnG22wSb39Y+KK/p3miCr
 ysz1lrzKgvZ/TKtPkkKkBe3B4lEWHkznP1pRpXtzemsguvq5F8knyyIdEqaWwUaNhcG03+qqL
 DZyQxmO8/mBVNlDG57OGX//wcDN/3U7oFNSTv1KZfo1cyReG6tcfWKdDXNYJ6qbuwCIkmxjLP
 wJZ3oMpg/mZBS7hQRSaQ7SMD/3/+PDXlxy9wGeN2rLvcz7mAtCVNMBqaFlM=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.06.19 12:25, Pali Rohár wrote:
> Hello!
> 
> Can somebody help with reviewing existing patches / pull requests for
> dosfstools project? https://github.com/dosfstools/dosfstools/pulls

I'll have a look at it. Could you perhaps prepare a (rebased) patch
queue ?

Does the project already have a maillist ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
