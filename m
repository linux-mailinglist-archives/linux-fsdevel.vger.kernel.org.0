Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0B391164F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 03:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLICJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 21:09:37 -0500
Received: from li1843-175.members.linode.com ([172.104.24.175]:57366 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfLICJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 21:09:37 -0500
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 21:09:36 EST
Received: from quad.stoffel.org (66-189-75-104.dhcp.oxfr.ma.charter.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 80E521EDDC;
        Sun,  8 Dec 2019 21:00:42 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id E9A93A5DE1; Sun,  8 Dec 2019 21:00:41 -0500 (EST)
Date:   Sun, 8 Dec 2019 21:00:41 -0500
From:   John Stoffel <john@quad.stoffel.home>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] fs: introduce is_dot_dotdot helper for cleanup
Message-ID: <20191209020041.et776tzhxqsqqfs5@quad.stoffel.home>
References: <1575718548-19017-1-git-send-email-yangtiezhu@loongson.cn>
 <20191208034144.GP4203@ZenIV.linux.org.uk>
 <20191208123804.GB32169@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191208123804.GB32169@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 08, 2019 at 04:38:04AM -0800, Matthew Wilcox wrote:
> On Sun, Dec 08, 2019 at 03:41:44AM +0000, Al Viro wrote:
> > On Sat, Dec 07, 2019 at 07:35:48PM +0800, Tiezhu Yang wrote:
> > > There exists many similar and duplicate codes to check "." and "..",
> > > so introduce is_dot_dotdot helper to make the code more clean.
> > 
> > Umm...  No objections, in principle, but... you try to say that name
> > (e.g. in a phone conversation) without stuttering ;-/
> > 
> > Any suggestions from native speakers?
> 
> I used "is_dot_or_dotdot" when discussing this patch with my wife verbally.

*thumbs up*  Both for the wife, and the name.  :-)

-- 
