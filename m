Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316E425ADE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgIBOtp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgIBOtn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:49:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B9C061244;
        Wed,  2 Sep 2020 07:49:42 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g3so3668003qtq.10;
        Wed, 02 Sep 2020 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErDxBP292qgM2mdm4g7gOIU3Qvf4dij7fK4XJfVrt7I=;
        b=fDRpDALP3bYgR3k1YEHRw6BXEs5qjmQfmVRQWhHf0hTi/Vh3J7y8xh42UsDaXWxp+Y
         0/TYBma5AgrIW6tV8iSjbjhBKth62GXZAjXRZk5EpOlXjmR08WpNGkfUY5GnsmB25Ozm
         goBYJK/tywAzaUqXg6XBV3SodkrPxZttoAfBNu3nJRVDalbCa9CCqbQBQcr2nKfL+4PL
         KBTbv8tuKuFMr4xLHJWWdhDYSR1c+kWpCn7Frqtkwf8sAduRWDR7R7uSDqrJWoflHvGk
         BPtNxz8bQwCH7t/Rj9GvDUH5LqbE4ttYa1SkqNoGkWkmH9qtOqKoxmYDmCf7JhIt++tw
         S0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ErDxBP292qgM2mdm4g7gOIU3Qvf4dij7fK4XJfVrt7I=;
        b=Fok1CMT9XjLkKf8PEZ18KF7d1VE7Zz3p4VE8LXLUVTWjACvaX4oakNodw8OiarUjAb
         VIj931ZPvmdnfYebClBDfhNpF3MTDBEvu53zNXuwQNOJisla5zCiODG4/13mWl10u7lv
         6/M8Y1d4k0Zr7DYWlh7LPETHzRGdTYU/VOf0l7HrDhn0CLGVKfI+R0H6trRoBKvPr8hA
         lF37ym8RniA5YCyiuL5M8e0PVTAq3EDJZSibbISvf+426/ZP5UtcjIMDwPwOkXKbLZJ5
         z+q6iXYgp4LHq3MXgCyW7iYb1AsOp4Z53OMo6/HkH4lPb6nW+6HKM34V4B136Wsh8Nl1
         Hn9Q==
X-Gm-Message-State: AOAM530unpogK9j+PE5Rq/SvXq4f12LwO1W05h5dKOlg1KYXAt8zj8QY
        vW1ndH+0+0qD/+OQdxmfreoky4BTUzAaxA==
X-Google-Smtp-Source: ABdhPJy/odyVVr3CmJTQ56PF7zNzYEEkAS3D/iWyhHTPHR1m5NSr/u0mWgQqCYJmcvCYZLmX8jzKtQ==
X-Received: by 2002:ac8:4052:: with SMTP id j18mr7058151qtl.352.1599058181467;
        Wed, 02 Sep 2020 07:49:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id f7sm4974480qkj.32.2020.09.02.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:49:39 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:49:36 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     trix@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: clear auto_free in initializaiton
Message-ID: <20200902144936.GF4230@mtj.thefacebook.com>
References: <20200818141330.29134-1-trix@redhat.com>
 <20200826161126.GB8760@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826161126.GB8760@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Aug 26, 2020 at 06:11:26PM +0200, Jan Kara wrote:
> > Which seems like a strange place to set auto_free as
> > it is not where the rest of base_work is initialized.
> 
> Otherwise I agree it's a strange place. I've added Tejun to CC just in case
> he remembers why he's added that.

I don't remember exactly but maybe I was trying to mirror the
CGROUP_WRITEBACK counterpart without actually thinking about it? The patch
looks good to me.

Thanks.

-- 
tejun
