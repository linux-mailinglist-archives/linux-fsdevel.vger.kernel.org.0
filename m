Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41404373E30
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhEEPMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:12:15 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:51235 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhEEPMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:12:14 -0400
Received: from [192.168.1.155] ([95.114.117.51]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MqJZl-1l930v2rat-00nNc8; Wed, 05 May 2021 17:10:54 +0200
Subject: Re: [PATCH 1/3] 9p: add support for root file systems
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Changbin Du <changbin.du@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20210505120748.8622-1-changbin.du@gmail.com>
 <20210505120748.8622-2-changbin.du@gmail.com>
 <YJKUqj5hY3q+qOia@codewreck.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <6c5a569a-4b4a-4aef-f32e-1832dc8936e6@metux.net>
Date:   Wed, 5 May 2021 17:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJKUqj5hY3q+qOia@codewreck.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LeoXAO/EDnIbZUmqFpAY/qXMmLkUnzipnG0qIG3v7etZ51RoSWC
 9AZKzGFbv6Awb93Jntax/RxRIf8ETvzH7C8nIy3gyUQJ6WD8iN+x5OzCN2pDER8ytsI/b0o
 fjIt8PSx7vtlkycVXd21XM+y6Ve9D9EeMzf23lHfiGQ7eTD+X2XFM8ScOL877Xf7aJWXwHk
 VK+DZjcHzOTmXMiun4Gqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E/fFbBXTx60=:tapgi5V++3Rs1otX4IWydq
 ArVCaevYvXQxw0ZH8Rlote/498H52sfZKiDspya46TlS19vvOFIDmHXY7YJDiGRgZEiZDnSmo
 Xam4D0VFNXNN7WS6Dcj11WHlJqDAbU3O2lVwTG+ibf6Y/r5Y6V+NQYifaS5EM3lj+zfv6p2jt
 GFfwy+msfnjdU+MrSWtd2zNH6E7b712zeve50ecI2d+0xeuru6RCyF1yNV/QwE/rllkwKRMcX
 X/nQGi0dTvMMn+hb3RbiRHDthN8S/plP9IDD37QworJMqBIlelNSpl2Ri8GqbInggFOTDFa8S
 +qA4i5MUk/PogzqvC/Y1ICPOOXb6V5h13F5wWKjw+oxD7gvmSp1Zc1EVd3mQZH/JyvlaaSAXM
 Styk76bRUKh/tjTr3hQQ6A9plUAIbKiFsacdvfFiKMtvIt+eIvP5j41rcl70yyWK/KFtwutcY
 t0FIPq5ujEuGo37ZRkQ/b9L0RRJxQKtArWE7yDOdxWX84tS/UC/KxOPxtldc5TnLzIb0pcH8S
 1cotRUeQ7e/SgeucJVq0MI=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.05.21 14:50, Dominique Martinet wrote:

> As a whole for the series: I'm personally not sure I'd encourage this,
> it can currently be done with an initrd if someone cares enough and if
> we're going to add all remote filesystems that way there's going to be
> no end to it.

personally, I'd be *very* interested in that, especially for specially
tailored vm grid workloads. please keep me in the loop.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
