Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2945AD177
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 03:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfIIBNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 21:13:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbfIIBNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 21:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qL5AmPwJsgMB2JQa1hapcmg4XfNq+0CQ3w+mAIP5SQ4=; b=JGHcyTVkIbErQE5YeNw3F48V+
        vHU70nXAbJ6WAm8c7SXaQRt6sqrxtDXoIupBqSnVX4ZNeKRDqkjwSOtvip9w8oh+3tLysO8/Ax4Aj
        RGd1LqHtVDSO+v5hIFnFZzB7Hi7p6Q/XAohiFNucEUKEMLpEFJOjNBNRCTeC0leUptEWLJKyiEdVG
        URXHSsrkMzaMtpxOizm5qQTmqqxrqDt3a+vsp9B4XoFeX75LcMCFKZKlsyqbAjdW++qV5szqkzDz4
        RJqeuXPgejQNib+WU2/YjnzeECb+c5O22Y9zVaJDXhgIpV0iP8qFqASTdMr+LJmVxPkEUZmwTEFGq
        XE1FyQ0dg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i78Ef-0000xz-Kp; Mon, 09 Sep 2019 01:12:53 +0000
Date:   Sun, 8 Sep 2019 18:12:53 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Johannes Weiner <jweiner@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, kbuild-all@01.org,
        linux-fsdevel@vger.kernel.org,
        Kirill Shutemov <kirill@shutemov.name>
Subject: Re: [kbuild-all] [PATCH 3/3] mm: Allow find_get_page to be used for
 large pages
Message-ID: <20190909011253.GC29434@bombadil.infradead.org>
References: <20190905182348.5319-4-willy@infradead.org>
 <201909060632.Sn0F0fP6%lkp@intel.com>
 <20190905221232.GU29434@bombadil.infradead.org>
 <4b8c3a4d-5a16-6214-eb34-e7a5b36aeb71@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8c3a4d-5a16-6214-eb34-e7a5b36aeb71@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:42:03AM +0800, Rong Chen wrote:
> 
> 
> On 9/6/19 6:12 AM, Matthew Wilcox wrote:
> > On Fri, Sep 06, 2019 at 06:04:05AM +0800, kbuild test robot wrote:
> > > Hi Matthew,
> > > 
> > > Thank you for the patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on linus/master]
> > > [cannot apply to v5.3-rc7 next-20190904]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > It looks like you're not applying these to the -mm tree?  I thought that
> > was included in -next.
> 
> Hi,
> 
> Sorry for the inconvenience, we'll look into it. and 0day-CI introduced
> '--base' option to record base tree info in format-patch.
> could you kindly add it to help robot to base on the right tree? please see
> https://stackoverflow.com/a/37406982

There isn't a stable git base tree to work from with mmotm:

https://www.ozlabs.org/~akpm/mmotm/mmotm-readme.txt
