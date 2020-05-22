Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2431DEDCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbgEVRB0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgEVRBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 13:01:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8F5C061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gLqD2Ym91EKXJBAHqVV2mYLV/Hm8QNgpM1LtVmbW9EE=; b=Z28LLEQQtpgCZPJ3IwfLU3iYy9
        Zhwmnelwl+XQVnbLmy19xC8vU8d741vxZkeV+1GcEEX9E8IxNmC5dd492xd290BHli1IH0lBb+eqg
        vA0W0yY0NioC7DG1OWZVLHoDVvspzREqk1x9rYn8x5WAZlmSPMBV1KLb1KMKyq8SiQIFWhBYeOsNC
        IyRGufBaeRJaJaMFAqPPCC/Wl38scppnqmzOOXdK8L1MBll5odpeqVluPNcjWA/rz6rfb1Io6WMus
        O+CEijwbJXZqJdYEA1w4+l1sR2EWLzorWh1acTzqmeVOXXqVd+FI9pM+ZdPOdYEtm7TqlfAikPJxk
        FL8AKr5g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcB2t-0003lX-S9; Fri, 22 May 2020 17:01:19 +0000
Date:   Fri, 22 May 2020 10:01:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove duplicated flag from VALID_OPEN_FLAGS
Message-ID: <20200522170119.GA31139@bombadil.infradead.org>
References: <20200522133723.1091937-1-kw@linux.com>
 <20200522154719.GS23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522154719.GS23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 04:47:19PM +0100, Al Viro wrote:
> On Fri, May 22, 2020 at 01:37:23PM +0000, Krzysztof Wilczynski wrote:
> > From: Krzysztof Wilczyński <kw@linux.com>
> > 
> > Also, remove extra tab after the FASYNC flag, and keep line under 80
> > characters.  This also resolves the following Coccinelle warning:
> > 
> >   include/linux/fcntl.h:11:13-21: duplicated argument to & or |
> 
> Now ask yourself what might be the reason for that "duplicated argument".  
> Try to figure out what the values of those constants might depend upon.
> For extra points, try to guess what has caused the divergences.
> 
> Please, post the result of your investigation in followup to this.

I think the patch is actually right, despite the shockingly bad changelog.
He's removed the duplicate 'O_NDELAY' and reformatted the lines.
