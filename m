Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1BAAAE3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 00:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfIEWMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 18:12:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfIEWMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 18:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hXxhd2FAe3cwB9R+ZW9hYGuNtaZo0DXOOGKLsZp7Vlg=; b=DwJAHupYCe0KBYPUY++xKXNtX
        KNFsVks8Q6faF0UinUX03iscnrEEQfBD9LwGf673IRScjuZIxM6EDPHpRjrDMW9W5Z/zdRbcI1iVj
        DmTiqJzddle/jwr2qPw+ONbSQ6MLp5ifm7oB/9fXTYpDoLz2Qp8vusbM+isLkyJOGaWl7flVTfq6u
        IIjPZa4Cq1Urw3dQY/kyB10TNLBthJdFR6BP/PEM9r3PKugJixBQnGhO08HXGTny2tArqIAFbrQnm
        zqt4d9Ud4ymRK2EVtu9MdO32qQum/vfbHzRJmM9CDxSHUGyTpivuPH266I6BS4s5wTxQQ725Wsn+X
        HBIDTWMtA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i5zzU-0004ms-F5; Thu, 05 Sep 2019 22:12:32 +0000
Date:   Thu, 5 Sep 2019 15:12:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Kirill Shutemov <kirill@shutemov.name>,
        Song Liu <songliubraving@fb.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <jweiner@fb.com>
Subject: Re: [PATCH 3/3] mm: Allow find_get_page to be used for large pages
Message-ID: <20190905221232.GU29434@bombadil.infradead.org>
References: <20190905182348.5319-4-willy@infradead.org>
 <201909060632.Sn0F0fP6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909060632.Sn0F0fP6%lkp@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 06:04:05AM +0800, kbuild test robot wrote:
> Hi Matthew,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc7 next-20190904]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

It looks like you're not applying these to the -mm tree?  I thought that
was included in -next.


