Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83EBD116188
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 13:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfLHMi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 07:38:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43270 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfLHMi2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 07:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2ELcNaQndnrwr3FiX1NwpMEheNcsO2lBa0QVqsnMeCA=; b=U1XvJNbZbJPCjOt3AAVxDS0oF
        Mh4MI6C2RCv9V/mL1VeDkpDKRcIa5JCrtsA48oc1ZWffNGpUIw9aDPdgh/eY/Z/Q4WtyE7XL7R13H
        aNZLECIv8MGDhMqhxhCqK1oiWpsqzhojIEowfJv2H/LvRalBHVMMUfsS4I77I7ns/h7iIXi4HWqwb
        GyxnngdRgaYtkRI5xGHMfFDIC8rl7qT9qa1tjyHUshnhjuP/W8K7z2hDCCVU0qUcb7uczdDPfpylS
        gPg1CQlcwkjyKfXr2gYv2md+i1a3Ba+MfYDEpJDNCATOzq/5SM/3hvEgbW0A9/aYLu+vajeb1GHPp
        ylpQUn9Uw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idvp6-00061v-LN; Sun, 08 Dec 2019 12:38:04 +0000
Date:   Sun, 8 Dec 2019 04:38:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: introduce is_dot_dotdot helper for cleanup
Message-ID: <20191208123804.GB32169@bombadil.infradead.org>
References: <1575718548-19017-1-git-send-email-yangtiezhu@loongson.cn>
 <20191208034144.GP4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208034144.GP4203@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 08, 2019 at 03:41:44AM +0000, Al Viro wrote:
> On Sat, Dec 07, 2019 at 07:35:48PM +0800, Tiezhu Yang wrote:
> > There exists many similar and duplicate codes to check "." and "..",
> > so introduce is_dot_dotdot helper to make the code more clean.
> 
> Umm...  No objections, in principle, but... you try to say that name
> (e.g. in a phone conversation) without stuttering ;-/
> 
> Any suggestions from native speakers?

I used "is_dot_or_dotdot" when discussing this patch with my wife verbally.
