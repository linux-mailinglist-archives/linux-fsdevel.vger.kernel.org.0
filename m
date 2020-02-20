Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2DEA16605D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgBTPBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 10:01:24 -0500
Received: from mout.web.de ([212.227.15.3]:45187 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgBTPBY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582210826;
        bh=n11cANuCYcYzok7hdryvNdn5gFdTh5KMCQi2bv2OokY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TFl3cW21AuBB2Qb7a2xXjgsFzeuKfJAPhJme42dPyN0TWt11/1MA/8M2432dO11RC
         eWVNFHPGJnArke4ZKvtVWa1tk7bpfq/VX9Sui8JsFB2AYu3EdQgBPoJUC/O3STCJSp
         lTBPV0d/gRNT7YaFgb0mpjVtZDC3xpEyr1zm4Ymc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.175.64]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LtXDY-1jU3TS2CaC-010shM; Thu, 20
 Feb 2020 16:00:26 +0100
Subject: Re: [for-next][PATCH 12/26] Documentation: bootconfig: Add a doc for
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
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5ed96b7b-7485-1ea0-16e2-d39c14ae266d@web.de>
Date:   Thu, 20 Feb 2020 16:00:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220221340.2b66fd2051a5da74775c474b@kernel.org>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uzw/wNVQzv5DyR9QsuqeuvLwmDEkJ6oQn7Ts9yNKnpZpUepc/zr
 hhYU0w8ZE0MUw5TcKrCUgL1vimqkMoFYSu9itN2ekJWpWGsJUvMhzmedtzzYPYjVGeegm/G
 ga4Tobs3N/5P6hD8gq+2COTpMmsICWpXlPTuGp3k8Idfx4X+bBXX8Gvaijp3rAS5HDdkFDe
 +/Hkmk3cTkWQsGmUCO4yw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wfeZLuJjyg0=:X10QpggogGWCsvM5cRIPXL
 Y3d+109y2KmfhbY/c3VcC9Pe/6CbsFmE4edaqmzFidMLe13nJs3sZga48rhgSMSfYkuPYvG1N
 skRaqExZEDdeMUl2385rRPKNn5HYQaaa8GVLQqjhshoKtktHhtCPltvMaHP+r9uVo+bCTgetX
 SzUBYbx8lXeCvh5mAYtLqRoRM0ZnUGKMigK4mJ8Q5jk8y1bZr46rfJ3dI2t58NaFA/DI0xkV7
 pvhGLtzHNh14ZvT3GG+OO/gBEwFACSdmQLibK6IYFTuTSH2kj5HTTAdNxWSqn7bVif4TGNtxV
 wH1s5X9yYS3vB/cE+7lZxTz6RjLT8mXLn8oJFYGG4gFrJ28QmzpqS4uPTNIRzv/804H61S2P6
 rfz6YpqHakUR8vPGfNRQUKkx+SEdTNO2eU6GOZ5VXh1j6IwJ6zrgED4w4A06jEyBQ8z5E961z
 PeB8W20qqs89qSkCaVd+GcZg7JCrZvzD2kfKlnX5cnWbNG4kFrUI/U2t6oEhrFUzUE7wMiAXv
 MZ40rIBPinqgAdQ9KTN5fEkIWpLVuj+HlJoCkfYDHv7aewnYLABgqEhD1TVGIjq1bONNzxyCT
 pXzYTlqmpu0qEXmm2tAnIAvNH5G9xWbcH2PiC0dm2MPxwURvPuFwVV13xwDc6RBbzaxyu/DWq
 UD5qMpNGCim64BeBBBJdTI6TT7oVcQFGdFOyy4WN3gR5Vj9uNL1HA6MKSREwxHF/ejtZulb+p
 j2Ym9RInQr0sx1XlUCgFcGsbYUSgwiq/yPuzxH/yhaPJjzuWmg/EXKVBgFK6JPY6SsbywV2W/
 UmDkZh0nSFgf5s8/F3r/A8ZO4dMo0mTrMMWbuu2aDYXavdzdS2WKcgyRPJR/uKs/kWUWLPwi5
 IGxTBkIbV/0iz1aYNbUqAY0555hDUBVdBmUoGhMoDEJcseGFDlm2nOVLQnEpVJFSYnOtWplQZ
 2FpmWsmIjONJZM6dOR9J9lPKcTAS0pOdygD+hoW59BM7BeSF8UJwvVq0tQStEoR040ESDP4Px
 E7uip761QuInqSzaHoc4NjxIz+blx2cIQdgTIsBIqQs/Tmdjdj9USZ6XHBVY47BeAvYcmVwwf
 3uQRXlgzt4HUImUuplF410M7zNl3OaVbw+cTnQzvqRGyFvM3ZHmNzkSJZUkxOn6TtoNq6r4S0
 NhCEaLL8O3tGM4beEMbel99OMAa3Ela/64nllaPuYbayHUON7s2KXUS0Stqd3HPPJVPY4ZZvb
 l6QlDkfms/KL1PAS1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>> +Currently the maximum config size size is 32KB =1B$B!D=1B(B
>>
>> Would you like to avoid a word duplication here?
>
> Oops, still exist.

Is there a need to separate the number from the following unit?


> Indeed, "node" is not well defined. What about this?
> ---
> Each key consists of words separated by dot, and value also consists of
> values separated by comma. Here, each word and each value is generally
> called a "node".

I have got still understanding difficulties with such an interpretation.

* Do other contributors find an other word also more appropriate for this =
use case?

* How will the influence evolve for naming these items?

* Is each element just a string (according to specific rules)?


>> Could an other wording be nicer than the abbreviation =1B$B!H=1B(Ba doc=
 for =1B$B!D=1B(B config=1B$B!I=1B(B
>> in the commit subject?
>
> OK, I'll try next time.

Will words like =1B$B!H=1B(Bdescriptions=1B$B!I=1B(Band =1B$B!H=1B(Bconfig=
uration=1B$B!I=1B(Bbe helpful?

Regards,
Markus
