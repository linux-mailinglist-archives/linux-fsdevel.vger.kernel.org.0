Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3274A645B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 19:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiBAS7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 13:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiBAS7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:59:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283CC061714;
        Tue,  1 Feb 2022 10:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/tI9u2Ypltzhai1bpQmE65R8Fxw9d0Y6jJ22UoOpzEM=; b=Z+YaRnqcADpjXJQ3iWfwIwJTsk
        oVAEj4qYkMfRUHeIeL+cTkDHgFHi7B8T+crUTH4666TA4VC7dX+RjkrynTFPBrQWLy26buc5OgS4E
        JFXc+w/Ka2AUMyxD9STnew/0khlNmnnNRxMkw7D8ILl1nZrSQi+B9ZV7NxKaNi+4rbkxeKJ0U4Jyt
        ZGMw9KI51kR+G+7NMVP0e1bf12pm8yzQG8EeKTm/BcYMLhGa02P0mF+BmQZpndc3EBJfVH5CzYYFz
        nzGc85n1KsBTK6OwjygRa0wOAYINn7TvZHrsKO728J1ksN8zTb+rcUYHcycL3JdGau/aN6d6aJPbj
        bS+62qqw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEyMp-00DSM2-WD; Tue, 01 Feb 2022 18:59:04 +0000
Date:   Tue, 1 Feb 2022 10:59:03 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tangmeng <tangmeng@uniontech.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     tglx@linutronix.de, keescook@chromium.org, yzaikin@google.com,
        john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5] kernel/time: move timer sysctls to its own file
Message-ID: <YfmC910yV8E1IKgb@bombadil.infradead.org>
References: <20220131102214.2284-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131102214.2284-1-tangmeng@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 06:22:14PM +0800, tangmeng wrote:
> kernel/sysctl.c is a kitchen sink where everyone leaves their dirty
> dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to places
> where they actually belong.  The proc sysctl maintainers do not want to
> know what sysctl knobs you wish to add for your own piece of code, we
> just care about the core logic.
> 
> So move the timer_migration sysctls to its own file.
> 
> Signed-off-by: tangmeng <tangmeng@uniontech.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
