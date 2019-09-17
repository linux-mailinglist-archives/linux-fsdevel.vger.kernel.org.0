Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1B7B46C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 07:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbfIQFP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 01:15:28 -0400
Received: from sonic301-20.consmr.mail.gq1.yahoo.com ([98.137.64.146]:36417
        "EHLO sonic301-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388220AbfIQFP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1568697326; bh=AhwlOckvccyE4ysmUMD5BMK/gwbKT5/hEQb6y+cMRsY=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=doCGybcdMUHL4nqHBB//ks8M0OG08uDUHfElj/xYQPCoROM0iy5ee3zmF8iUqyETv0ZAo2ou0ojaVJJQAcwi0AviI7XR+immJkdWXcu6l6hB+7DT/yeuOF4AK4G1wxKD1E7Gnz9HvBNlXJQwIhqwtSrWgBUqEdf1W1EO0c+kILu8MW4SQ3NzYpmD/dnTNukqp6UKbGjdLFPW9Dw9UOBABvFKEE3DY6tPYNYu8NedmXX3Kh2DYiAyxYPMuX7NUatFHYCrSkt5Rta/ho/6LmZz3bhpssmGLb5WaeIQGFS7wQpPYaeD6HLeT23dtUZwlmrdqAKNEurC0Y6OoAongs2RcA==
X-YMail-OSG: GxorC3EVM1nHmDVxUdfLQlpFhahMbf_7tT23iP7NgeCDiuXTyF9f8pZ5HSC1.xN
 gdHvQRdKK7kCEaIreg9_KhtRHesRMXHrm8YNJK3PL2_Zy0ufZlHm3tkUt30BSEsv9yINSIDBdCZn
 9EwGrFBnT106nEEdpH8vvtLpVhd3ET5yt6.aJbDQoMhlTbBZB2ETxcbyf4cQpO_n099_mFvZggqk
 4ytnmtcU.sBcY10bZGc3Y338GuImDwAkGyPmQqgLgOh7vzNJPC4FIjdKTW4FOhr2Unm7pZ85ZF5E
 hZhMeLJXgNn9lx9RepSili.L.2aNCODwIsERJp_5jE4SR13kPjZRQ2joXanyCbH8tTcw3jYuym4s
 RrZYIMLc09oqO9yv5n9CEOQjGTZZStlxXjMxNqpYZbSyp6W1D.ZFP_xImEPHE.iA0dLEiRBGX6a_
 tAsEAeDXcd_HKhi4C41BwlV9bDpHxxkHHHHeZgBGmwPp8JJpWLtgUZkCF4oKXgARxNi7pBUpXnEw
 lG0FF7NJ8clVJun.lFdtAvwnecqFtZx4f65u2yMUsP4.apd8PiT1nrYfRS73M0UY3pYjAV2Mot82
 E83rGo8yBU8wkwZG0APbB8.uDDj88.7JNm_mKsQFn6qmOdYfVnbkOy9OHjszmjNFXREa8EKrGXIV
 ByZHt3ePjBY3jncIWnMAOaf2o.QWPdNZGsb77WQGdvYLxvj3aRDP2aW_Is3wfgOCj_z.Q4oQ7vR3
 OA6sJXU2yLx3GbJS_mWheW5TmBWCd...iZMzgL7TIgjPmLN3Ve5YgEMddLhMXn.2UYBEAUyjVF.t
 fzK98ndiMAKdzIIAD5UM_CRS9mYZqsOXehl9_3cqly1bHaqqb2UysgDHbgLUoLLz4toDcBvguLn2
 Iox5eWfTmoW3H7.DCxdHSWx9DooL_8Ij6y_R9kGvUtlzTjkIJtNzK0p567NkTjwm5vE._OLJJIGV
 McPpTHZ8DtCiD2ALEtHDYm2qx6xBflaIpxv.3twuKvy9eu1k1zQd3ZPlOCMOItNu.URYPXpzRgSQ
 7fW3aLoBjspLl2tkA5mjrGtTr3jtkUxXCS6nEsHhrWZzr.B6njPiZRm2mCzd1cp8XW9YPjbt_ZX0
 8O9mxnd.shlapPDJsVS2jw4THp6lAeWhE6lTRz8AjMP5wq.ywEsjMvC1BvNNRYpJnlgmLQNNwtjs
 H3zrHEhdLYlSdiF4x3AZvvwVDguro3Us9FVnkmdW5xR00fxg2XznYrbrD6djxargI8YMnArS.u4X
 eapxsIbCE272sbMkyZON6l4I4XGcvPFrZ1_inJRV02GqZCL1O3Fq._hyoQ7fxOZFL8v6Iv2yg8wL
 e3y.zgenDvwhbggKUENe0FDnqIeSm69pdIarjhg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Tue, 17 Sep 2019 05:15:26 +0000
Received: by smtp405.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 426117e608ffd8534b66767bfb4416c3;
          Tue, 17 Sep 2019 05:15:22 +0000 (UTC)
Date:   Tue, 17 Sep 2019 13:15:15 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Greg KH' <gregkh@linuxfoundation.org>,
        alexander.levin@microsoft.com, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        sergey.senozhatsky@gmail.com, Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190917051510.GA22891@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <CGME20190917025738epcas1p1f1dd21ca50df2392b0f84f0340d82bcd@epcas1p1.samsung.com>
 <003601d56d03$aa04fa00$fe0eee00$@samsung.com>
 <003701d56d04$470def50$d529cdf0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003701d56d04$470def50$d529cdf0$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14303 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, Sep 17, 2019 at 12:02:01PM +0900, Namjae Jeon wrote:
> We are excited to see this happening and would like to state that we appreciate
> time and
> effort which people put into upstreaming exfat. Thank you!
> 
> However, if possible, can we step back a little bit and re-consider it? We
> would prefer to
> see upstream the code which we are currently using in our products - sdfat - as
> this can
> be mutually benefitial from various points of view.

(Only represent my personal views)

I'd like to know the detailed commit history as an individual Android hobbyist.

I noticed sdfat years ago and there is a difference from the previous exfat driver.

I have no idea it's a good way to blindly keep the code from some opensource tar
on some website. and so many forks on github (hard to know which one is more stable,
cleaner or latest)... someone could take more time and play a role in that actively
in the community and maybe draw a roadmap of this so I could study more and maybe
contribute a little in my spare time.

And I think if it permits, development on multiple branches could be avoided...
If I am wrong, please ignore me...

Thanks,
Gao Xiang

> 
> Thanks!
> 
> > ---------- Forwarded message ---------
> > ????????: Ju Hyung Park <qkrwngud825@gmail.com>
> > Date: 2019?? 9?? 16?? (??) ???? 3:49
> > Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
> > To: Greg KH <gregkh@linuxfoundation.org>
> > Cc: <alexander.levin@microsoft.com>, <devel@driverdev.osuosl.org>, <linux-
> > fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Valdis Kletnieks
> > <valdis.kletnieks@vt.edu>
> > 
> > 
> > Hi Greg,
> > 
> > On Sun, Sep 15, 2019 at 10:54 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > Note, this just showed up publically on August 12, where were you with
> > > all of this new code before then?  :)
> > 
> > My sdFAT port, exfat-nofuse and the one on the staging tree, were all
> > made by Samsung.
> > And unless you guys had a chance to talk to Samsung developers
> > directly, those all share the same faith of lacking proper development
> > history.
> > 
> > The source I used was from http://opensource.samsung.com, which
> > provides kernel sources as tar.gz files.
> > There is no code history available.
> > 
> > > For the in-kernel code, we would have to rip out all of the work you did
> > > for all older kernels, so that's a non-starter right there.
> > 
> > I'm aware.
> > I'm just letting mainline know that there is potentially another (much
> > better) base that could be upstreamed.
> > 
> > If you want me to rip out older kernel support for upstreaming, I'm
> > more than happy to do so.
> > 
> > > As for what codebase to work off of, I don't want to say it is too late,
> > > but really, this shows up from nowhere and we had to pick something so
> > > we found the best we could at that point in time.
> > 
> > To be honest, whole public exFAT sources are all from nowhere unless
> > you had internal access to Samsung's development archive.
> > The one in the current staging tree isn't any better.
> > 
> > I'm not even sure where the staging driver is from, actually.
> > 
> > Samsung used the 1.2.x versioning until they switched to a new code
> > base - sdFAT.
> > The one in the staging tree is marked version 1.3.0(exfat_super.c).
> > I failed to find anything 1.3.x from Samsung's public kernel sources.
> > 
> > The last time exFAT 1.2.x was used was in Galaxy S7(released in 2016).
> > Mine was originally based on sdFAT 2.1.10, used in Galaxy S10(released
> > in March 2019) and it just got updated to 2.2.0, used in Galaxy
> > Note10(released in August 2019).
> > 
> > > Is there anything specific in the codebase you have now, that is lacking
> > > in the in-kernel code?  Old-kernel-support doesn't count here, as we
> > > don't care about that as it is not applicable.  But functionality does
> > > matter, what has been added here that we can make use of?
> > 
> > This is more of a suggestion of
> > "Let's base on a *much more recent* snapshot for the community to work on",
> > since the current one on the staging tree also lacks development history.
> > 
> > The diff is way too big to even start understanding the difference.
> > 
> > 
> > With that said though, I do have some vague but real reason as to why
> > sdFAT base is better.
> > 
> > With some major Android vendors showing interests in supporting exFAT,
> > Motorola notably published their work on public Git repository with
> > full development history(the only vendor to do this that I'm aware
> > of).
> > Commits like this:
> > https://github.com/MotorolaMobilityLLC/kernel-msm/commit/7ab1657 is
> > not merged to exFAT(including the current staging tree one) while it
> > did for sdFAT.
> > 
> > 
> > The only thing I regret is not working on porting sdFAT sooner.
> > I definitely didn't anticipate Microsoft to suddenly lift legal issues
> > on upstreaming exFAT just around when I happen to gain interest in
> > porting sdFAT.
> > 
> > If my port happened sooner, it would have been a no-brainer for it to
> > be considered as a top candidate for upstreaming.
> > 
> > > And do you have any "real" development history to look at instead of the
> > > "one giant commit" of the initial code drop?  That is where we could
> > > actually learn what has changed over time.  Your repo as-is shows none
> > > of the interesting bits :(
> > 
> > As I mentioned, development history is unobtainable, even for the
> > current staging tree or exfat-nofuse.
> > (If you guys took exfat-nofuse, you can also see that there's barely
> > any real exFAT-related development done in that tree. Everything is
> > basically fixes for newer kernel versions.)
> > 
> > The best I could do, if someone's interested, is to diff all versions
> > of exFAT/sdFAT throughout the Samsung's kernel versions, but that
> > still won't give us reasons as to why the changes were made.
> > 
> > TL;DR
> > My suggestion - Let's base on a much newer driver that's matured more,
> > contains more fixes, gives (slightly?) better performance and
> > hopefully has better code quality.
> > 
> > Both drivers are horrible.
> > You said it yourself(for the current staging one), and even for my new
> > sdFAT-base proposal, I'm definitely not comfortable seeing this kind
> > of crap in mainline:
> > https://github.com/arter97/exfat-linux/commit/0f1ddde
> > 
> > However, it's clear to me that the sdFAT base is less-horrible.
> > 
> > Please let me know what you think.
> > 
> > > thanks,
> > >
> > > greg kh
> > 
> > Thanks.
> > 
> 
> 
> 
