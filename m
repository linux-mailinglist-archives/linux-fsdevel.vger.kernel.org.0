Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38D412BF54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 22:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfL1VYE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 16:24:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41942 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfL1VYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 16:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zLyVtTHQP0qB429cGv3ANO+U7B40Aa82NvPIBfmWqwg=; b=hB4K0TDkG3RRAnEl1Y+ZYqbbK
        ZY7VAuimGTV1vmCt6ywwxqF9wR0nZHdZqMa32rUGRSmeM03OFAG1/6nHU7CZeAjB4VcYawLsfBlsJ
        dfngRnsdJtjf5oIocq9auuJfHMkHBJ8lg+1qvxpsbYh3HjmgQHnm0SauMyuk24XV81UbQDgLHTj4F
        XYtHL2NkQyyAHYZsqVYZU4Zz0ZvsMj0YzdyfRPEaXSwESbP3VhgzxTYlN6cbhxyo/xQUgVuAzqFpP
        Xy1Rl8615pJPcKW5VpkG3aw6HsDZRrDJZriT6pacEVkS45b9lejKHBSDM7sJ/tK2j4FETuHjAG+kn
        QrJqM6Giw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ilJZ5-0007Vf-UV; Sat, 28 Dec 2019 21:24:03 +0000
Date:   Sat, 28 Dec 2019 13:24:03 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Mahdi Ghorbanian <indigoomega021@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: flag specifications for structs
Message-ID: <20191228212403.GA21831@bombadil.infradead.org>
References: <20191228155559.GA2115@user-ThinkPad-X230>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228155559.GA2115@user-ThinkPad-X230>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 28, 2019 at 10:55:59AM -0500, Amir Mahdi Ghorbanian wrote:
> Hello fellow kernel hackers,
> 
> I am currently considering tackling the following item
> from the TODO list in the drivers/staging/exfat directory:

Probably not worth doing.  See the patches from Namjae Jeon recently
which entirely replace this filesystem.
