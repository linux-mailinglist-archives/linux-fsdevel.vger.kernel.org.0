Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF8C192ABC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgCYOFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 10:05:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49024 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgCYOFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:05:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH6ea-002WJg-If; Wed, 25 Mar 2020 14:05:08 +0000
Date:   Wed, 25 Mar 2020 14:05:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
Message-ID: <20200325140508.GN23230@ZenIV.linux.org.uk>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
 <20200325021327.GJ23230@ZenIV.linux.org.uk>
 <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
 <20200325040359.GK23230@ZenIV.linux.org.uk>
 <20200325055830.GL23230@ZenIV.linux.org.uk>
 <20200325140207.GM23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325140207.GM23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 02:02:07PM +0000, Al Viro wrote:
> > +		if (unlikely(error))
> > +			return ERR_PTR(error);
			return error;
that is
