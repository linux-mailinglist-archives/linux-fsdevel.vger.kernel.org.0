Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EFF14A207
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgA0Kdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:33:31 -0500
Received: from mout.web.de ([217.72.192.78]:55877 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbgA0Kda (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580121200;
        bh=dAxxIGooUrpYMIc/V5niU8NEItO2A/L1D6LYedd4Kb4=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=pDVDeWUijHd9MkaNRudVD/YH1I1LPCrNFxcPjaTfsnwgSJzoE3F6iwJmZOq5l0vSk
         3/FEHv8Tp5DZxd0nofq/5dMP2EwxZ7Nk8ZTo64yLywlDIeU2Hrk2muudHzVZtdrln3
         ZRxm7/UHKNvsvUkaN6eG5B2z5+mtGU2jWGcZcQ3s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.115.58]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lu4q2-1jcGik2Uti-011RLl; Mon, 27
 Jan 2020 11:33:20 +0100
To:     Pragat Pandya <pragat.pandya@gmail.com>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
Subject: Re: [PATCH 02/22] staging: exfat: Rename variable "Month" to "month"
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c13908ad-7fd7-440a-c124-fc03b40550fa@web.de>
Date:   Mon, 27 Jan 2020 11:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:E37ita8Ugrj/UrKWQ63qcGY6XsZp8uDz2q3DgIHc3BwRdSB0Ah7
 fkHqltEhZV4rlf8mT9hkinNtb72w3ET5zmUj5pfEE4bM46h7TVYOeZNawvOaczUdP/mnkXQ
 zQ6meUW4OgK7EfwcspK0hI3DWDoAnAOeFeTInqggwmZsQTB1d98ygV23R5v9MUyAZLy15hs
 RbEsOKQAhaz9e4sTuKI5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tkgKyvG1rho=:sWO1AN5coqfwUnrGtrhPCc
 9Zzoblp78grRn058b5dV4ha66IYo9aIy9x3YUwScnCqS3gvtIl3YEy2LWXHjsMGPfP7Br+MVn
 SeeydV9WS2xx2AGlwjFJyp4gDDxN8fZIscoRE3Qa2hwq/eOXFPHZNRdt+HmIdy4Y24qU17tsm
 My6eN38VHQ4IvFUsL9q1pP2IUKNjLvDwu6puJObvidxAg8VEaVCbfRr7tKjd2nK6gDLTyZKbZ
 jqSDbrcQ8bqmqxmz3lxDFpoPS26UgpGqKLXBXHhb1LcgYAA/ol1LkZ1IEBTX+7ChUiXdflhNt
 SjiYokCxJkTWmCujFofeaC+9gjWhfgEmoSiljpkaihq5fc4/ltjhpweK+oCCKAsoIbxMAz6NO
 tVxJ8MpP3TFFI/AfxVNEfPcREwZuOa4Ghham+zmGEXGKeFR+Lm0treI7Z9gJDdVv+Y7Czo8/1
 LpTA3maXWBg0lWRic+46/kAJ2M01woD7VVonQ2EJNieD3rM6j5sKk2XNkc+SilUyf8eMsktgR
 DJiEUj7te9yegvoViMyE3kbymr+2mblgKfaQ7BYU354MebaDueyGiaBfovu2/ZJHJ/cQw5CFr
 HVcmXmCUWg8V/xAH5jexQCi/FuBgjkp+1Lkpck00yYnH5ky05cLscj0uq2Hc+SZZfyBqA0aGF
 cUo4mKq4qSvV1toBPLbPiXW3CPyJp7HZ4UlEKLvvGPVbtdGmYClKlcS92GP4V54EaLpdSR3a6
 Wjvi/X5seENL2GlYXwdPFDwvMKIBYyLndb9McVpM3PgZdRxFdX4Omah6L/WfgoJCL3SL32Qex
 KCFIgzEgx17+c2R9RCqKOxv/f/rAb5OkgIbEojlCCmg0prSZJRlTkFPNomKfBDBqy2wFYHBTN
 x1HIkwv2pss7g40GoSDLTkBI3u84zzEvzkOwfbsQk+DV41HGKQyZybPN2lkr5oECnTO586bk9
 8+x3sEVLScfhEWswDatPIGRH25mcUjTU3fq82nfdEfiMUvSEMQb3mMGYlIeVxJbp0e6JkVP66
 mXZAUiSwZeb9asR26/4pTIts1Zw9aorInMqvyFptX5RukRrFZSJGYIYPjJv4BN8is+g7x59jT
 aUWMUU6FSbSpCI05oDc7K4PKr7W8mPqgA7YwWwIn2vXRq+7ytnyr0p+HJMmzhgjIdIntekGei
 3zxOSmUGNLR398lMGEQRNHdD+jxNzSBv+OhzMXYQRIpVZuGAjq6iuVisj1b61DPCjTyxwPVjI
 PQOO8N/XvMn5psdFN
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Change all the occurrences of "Month" to "month" in exfat.

I hope that the final commit will not contain a misplaced quotation character
in the subject.

Regards,
Markus
