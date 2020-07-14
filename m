Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED96D21F248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGNNRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGNNRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:17:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A062C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 06:17:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so5652194wmh.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d75pcvvIGfiPGCva/f0SU32e25ehxdeK1OLvvmcTNzs=;
        b=xZJRYfRmFdac9r9m4l5Oy0YXQzVntY6h6gHYS59TXAzqGk7PozLnXbEgvVeBEfgsG1
         j5KCdV79ydL1Pmkcvpyl6A2x0lJGVusosbnbzESLh0q6w/gDVP2F4aAtmeijmvRFkUJc
         QZLMe4bHLpBGP3bmmXuu+8EZhcrN3GONmykZUZa0AqsKNQfB5CLmbfxWCPBZObyepk7h
         NiwVxKswpwqoMfeeA8lDK3j101J5kpYpeOfVnj2sWmJfwRtTdgs/YQMzGWDLMkdVkgFD
         TmeRO8KUumnneZarspsvCf9JgO4kHmD/edN/P9s9+FMioMVLvnRJOyPUv7pP0fNlQkPt
         3GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d75pcvvIGfiPGCva/f0SU32e25ehxdeK1OLvvmcTNzs=;
        b=WVQVgOV4D+R/HDIayjrENhwI7mKFwxYXN3qvTL90synzmGD5UIpk5sYXdcIAiCVsOl
         gWDc6MIoKEOUGZmdaH3a60Fcb0wWJcswSc2sl5k3t/epFz+mNG6+a0GuQhVF9PXXkwgV
         JmK6ZR0kRS3+lJWof+iCbWbalt0Tj/+ghtxQi1P6G3HBORaXs8IDBshivR6hrYwezgJx
         s+WYVKCeCP57tJ7Yt8DWGFA281jL6jlBxZIKvRZfUya9mpjZMwTTG6YgmVMDoXf2MjRg
         56dnhiXx1bf06w7jV3ZR1h9aIQ/lMIDylVqLlCVoxlXXphQ5hMvRnSrd6FGInK+PlUsp
         hI0Q==
X-Gm-Message-State: AOAM533WshTVgZr6woeBhhYuKuVg8SiYvliGtsfOwo68G+4wSUbZXkEc
        DJh0Dk/51ft+ESb2tanz0R5Ail7RGBY=
X-Google-Smtp-Source: ABdhPJw2BTMMsA6nNSRrZOBQfrfiTzcJRLVRP99DkEL1Bb3LwjTJuLW6XXC4riuxym2Z6YSXvEm3Xw==
X-Received: by 2002:a1c:28c4:: with SMTP id o187mr4340928wmo.62.1594732639716;
        Tue, 14 Jul 2020 06:17:19 -0700 (PDT)
Received: from ?IPv6:2a00:a040:196:431d:6203:64fa:e313:fb47? ([2a00:a040:196:431d:6203:64fa:e313:fb47])
        by smtp.googlemail.com with ESMTPSA id x185sm4605803wmg.41.2020.07.14.06.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:17:19 -0700 (PDT)
Subject: Re: Unexpected behavior from xarray - Is it expected?
From:   Boaz Harrosh <boaz@plexistor.com>
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <9c7b1024-d81e-6038-7e01-6747c897d79e@plexistor.com>
Message-ID: <bbc1e7ac-0e95-52c6-a8a3-3798db4ce6f5@plexistor.com>
Date:   Tue, 14 Jul 2020 16:17:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9c7b1024-d81e-6038-7e01-6747c897d79e@plexistor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/07/2020 14:24, Boaz Harrosh wrote:
> Matthew Hi
> 

The below patch will off course revert to the behavior I have expected from
single-entry-at-0 and the call to xas_next().

But not sure it is the fix you would like.

[An option-2 below also works]

Please advise

------
option-1
------
git diff --stat -p -M -W HEAD -- /net/Bfire/home/boaz/dev/zufs/zuf/lib/xarray.c
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 446b956c9188..1cebb148cae6 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -171,28 +171,28 @@ static void *set_bounds(struct xa_state *xas)
 /*
  * Starts a walk.  If the @xas is already valid, we assume that it's on
  * the right path and just return where we've got to.  If we're in an
  * error state, return NULL.  If the index is outside the current scope
  * of the xarray, return NULL without changing @xas->xa_node.  Otherwise
  * set @xas->xa_node to NULL and return the current head of the array.
  */
 static void *xas_start(struct xa_state *xas)
 {
 	void *entry;
 
-	if (xas_valid(xas))
+	if (xas_valid(xas) && (xas->xa_node || !xas->xa_index))
 		return xas_reload(xas);
 	if (xas_error(xas))
 		return NULL;
 
 	entry = xa_head(xas->xa);
 	if (!xa_is_node(entry)) {
 		if (xas->xa_index)
 			return set_bounds(xas);
 	} else {
 		if ((xas->xa_index >> xa_to_node(entry)->shift) > XA_CHUNK_MASK)
 			return set_bounds(xas);
 	}
 
 	xas->xa_node = NULL;
 	return entry;
 }

------
option-2
------
git diff --stat -p -M lib/xarray.c
 lib/xarray.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 446b956c9188..a9576acd34ab 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -186,8 +186,9 @@ static void *xas_start(struct xa_state *xas)
 
 	entry = xa_head(xas->xa);
 	if (!xa_is_node(entry)) {
+		set_bounds(xas);
 		if (xas->xa_index)
-			return set_bounds(xas);
+			return NULL;
 	} else {
 		if ((xas->xa_index >> xa_to_node(entry)->shift) > XA_CHUNK_MASK)
 			return set_bounds(xas);

> First I want to thank you for the great xarray tool. I use it heavily with great joy & ease
> 
> However I have encountered a bug in my code which I did not expect, as follows:
> 
> I need code in the very hot-path that is looping on the xarray in an unusual way.
> What I need is to scan a range from x-x+l but I need to break on first "hole" ie.
> first entry that was not __xa_store() to. So I am using this loop:
> 	rcu_read_lock();
> 
> 	for (xae = xas_load(&xas); xae; xae = xas_next(&xas)) {
> 		...
> 	}
> 
> Every thing works fine and I usually get a NULL from xas_next() (or xas_load())
> on first hole, And the loop exits.
> 
> But in the case that I have entered a *single* xa_store() *at index 0*, but then try
> to GET a range 0-Y I get these unexpected results:
> 	xas_next() will return the same entry repeatedly
> I have put some prints (see full code below):
> 
> zuf: pi_pr [zuf_pi_get_range:248] [5] [@x0] GET bn=0x11e8 xae=0x23d1 xa_index=0x0 xa_offset=0x0
> zuf: pi_pr [zuf_pi_get_range:248] [5] [@x1] GET bn=0x11e8 xae=0x23d1 xa_index=0x1 xa_offset=0x0
> zuf: pi_pr [zuf_pi_get_range:248] [5] [@x2] GET bn=0x11e8 xae=0x23d1 xa_index=0x2 xa_offset=0x0
> zuf: pi_pr [zuf_pi_get_range:248] [5] [@x3] GET bn=0x11e8 xae=0x23d1 xa_index=0x3 xa_offset=0x0
> zuf: pi_pr [zuf_pi_get_range:248] [5] [@x4] GET bn=0x11e8 xae=0x23d1 xa_index=0x4 xa_offset=0x0
> zuf: pi_pr [zuf_pi_get_range:248] [5] [@x5] GET bn=0x11e8 xae=0x23d1 xa_index=0x5 xa_offset=0x0
> zuf: pi_pr [zuf_pi_get_range:248] [5] [@x6] GET bn=0x11e8 xae=0x23d1 xa_index=0x6 xa_offset=0x0
> 
> The loop only stopped because of some other condition.
> 
> [Q] Is this expected from a single xa_store() at 0?
> 
> [I am not even sure how to safely check this because consecutive entries may have
>  the same exact value.
> 
>  Should I check for xa_offset not changing or should I use something else other than
>  xas_next()?
> 
>  Do I must use xa_load() and take/release the rcu_lock every iteration?
> ]
> 
> Here is the full code.
> 
> <pi.c>
> #include <linux/xarray.h>
> 
> #define xa_2_bn(xae)	xa_to_value(xae)
> 
> struct _pi_info {
> 	/* IN */
> 	ulong start;	/* start index to get	*/
> 	uint requested;	/* Num bns requested	*/
> 	/* OUT */
> 	ulong *bns;	/* array of block-numbers */
> 	uint cached;	/* Number of bns filled from page-index */
> };
> 
> void zuf_pi_get_range(struct inode *inode, struct _pi_info *pi)
> {
> 	XA_STATE(xas, &inode->i_mapping->i_pages, pi->start);
> 	void *xae;
> 
> 	rcu_read_lock();
> 
> 	for (xae = xas_load(&xas); xae; xae = xas_next(&xas)) {
> 		ulong  bn;
> 
> 		if (xas_retry(&xas, xae)) {
> 			zuf_warn("See this yet e=0x%lx" _FMT_XAS "\n",
> 				 (ulong)xae, _PR_XAS(xas));
> 			continue;
> 		}
> 
> 		bn = xa_2_bn(xae);
> 
> 		zuf_dbg_pi("[%ld] [@x%lx] GET bn=0x%lx xae=0x%lx xa_index=0x%lx xa_offset=0x%x\n",
> 			   inode->i_ino, pi->start + pi->cached, bn, (ulong)xae, xas.xa_index, xas.xa_offset);
> 
> 		pi->bns[pi->cached++] = bn;
> 		if (pi->cached == pi->requested)
> 			break; /* ALL DONE */
> 	}
> 
> 	rcu_read_unlock();
> }
> <pi.c>
> 
> Thank you for looking, good day
> Boaz
> 

