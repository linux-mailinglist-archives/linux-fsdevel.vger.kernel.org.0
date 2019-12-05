Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF846113C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 08:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfLEHHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 02:07:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49460 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEHHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LMxh8PsOTdp3uRQncunavdBObTQIFTMPychpOdLcPaI=; b=ttZfZk2NbSMy0oKG8mJmZ66Jj
        Fr2AaQPAQqEz8B84HALo6GcQCEvz6v2yxXag6Gy/NeuZOLwkz+gBEp23dDd+yR/qVEhJkP7Lj27Lk
        MfvFttoe/KNP8O0pMCqzioRjX9qHDS+PsLyRnO/1CMlsDkfPDZ3cZ1r1u3Wcy/ZDQT/RuLvQVGG4K
        UXQjHkpQNLXt+eg6Qj+SoFYbHmN17I6l+YXFi8nW0sipytrDTPPGYLilIqMGTyuHHSh2Wsb58lDEc
        yVX5I2tHXwNjpjfCJiA8HUoWnTAmyfb+Zbo4MaWO0emJolsCELJj6F6bvRQafPqYCOHC/9e6BgqFR
        24GFHE76Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iclDq-0008IY-St; Thu, 05 Dec 2019 07:06:46 +0000
Date:   Wed, 4 Dec 2019 23:06:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: introduce is_dot_dotdot helper for cleanup
Message-ID: <20191205070646.GA29612@bombadil.infradead.org>
References: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
 <20191203135651.GU20752@bombadil.infradead.org>
 <0003a252-b003-0a8c-b4ac-6280557ece06@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0003a252-b003-0a8c-b4ac-6280557ece06@loongson.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 08:56:07AM +0800, Tiezhu Yang wrote:
> > And, as I asked twice in the last round of review, did you benchmark
> > this change?
> 
> Before sending this v2 patch, I have done the test used with your test
> program and already pointed out the following implementation is better:

I didn't mean "have you run the test program i wrote".  I meant "have you
booted a kernel with this change and done some performance measurements
to see if you've changed anything".
