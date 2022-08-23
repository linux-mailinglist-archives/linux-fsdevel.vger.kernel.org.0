Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81C859ED3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiHWUR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 16:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHWUPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:15:09 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0D249B41;
        Tue, 23 Aug 2022 12:37:31 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z187so14383950pfb.12;
        Tue, 23 Aug 2022 12:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=kxeD7t6AephRFE0VvTfMAllbUT0ZPa2W2zfu9iRzx6o=;
        b=NNc0g5zX4Rk3hhtpLy68iQ5KjKuhXHl573Sw56xUyXvN3TvClXdEratdWpbNeNl7FA
         yB7/XCecUngtsYrXCx+Vu/scUmO/OnBJIWtSWbrKEs7Ip/MBR0SCsfUKCtSKkY6uV0b1
         TwUPZp5u5+8k3X+vD2eZArCdj9X/9IxsEl6LRcCpvSh/aP9LVpOvfOIdrAVt4/Fn+abG
         7oOWGE7BEF5Dx6SIfBNVe4VmuxyuVxVFEmaMT1wEqa8CvaXi+32I4E4ghdO76fRfdcvW
         JTWpH94Kr/xC3sCkGHgxxhBk+v6iGP8nXxADAmgDIijEPlPBoE0YaNf0MaANXGnf0aYd
         n9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=kxeD7t6AephRFE0VvTfMAllbUT0ZPa2W2zfu9iRzx6o=;
        b=XamNLtkhVZpVIxdHA4zKvh13ktGDBHHRbvzXV1sWOwZXnDqYWGz+TvNb8SVT7fB/YG
         Mw0DPfUUogsIh6Zyer896wdhqEAkiOd+vYClEqP47jvkrmYJWFq6BIViHDpDDNPANWbM
         2oj3PAdfifN9LgdJG2ZCjs+TNnWdCqNZsztKZGbtIDwEJuzCc3Jt5d3DluV+A9AmL+2+
         KEMO5dBbktqWYwUY9g+p16C+KoF50B3XRrOqocl/WIw9gp58eygDaWhXWZHXGLnNXECh
         h3q0ttsjzzWA3V511lsYS23WXu/bu54HHlKdw5pCKxKavA7KMSV+m6tEon5Nxqx2IfVP
         vJkQ==
X-Gm-Message-State: ACgBeo3GIUg0/VZlVI6JYu05D9xgYW19UlfOI1B8e3JuaglXydEmvlUW
        xRFE+9fKBe32yA/x5t9O0LY=
X-Google-Smtp-Source: AA6agR5B2R0kKGDPnXohyBoZRX7quqVG5GU/3TcvmqxcfEH9pEy4AK9DS9MRIS2vFGmHiL9z+RsiAw==
X-Received: by 2002:a05:6a00:1883:b0:536:e59f:f776 with SMTP id x3-20020a056a00188300b00536e59ff776mr6229940pfh.49.1661283450756;
        Tue, 23 Aug 2022 12:37:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90fa])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b001708e1a10a3sm10944120pla.94.2022.08.23.12.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:37:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 09:37:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
Subject: Re: [PATCH 4/7] kernfs: Skip kernfs_drain_open_files() more
 aggressively
Message-ID: <YwUseD1GBHd2iN+q@slm.duckdns.org>
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-5-tj@kernel.org>
 <e340ccaa-92f2-3870-ed26-70df87ad8c8f@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e340ccaa-92f2-3870-ed26-70df87ad8c8f@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 23, 2022 at 01:27:22PM +0800, Chengming Zhou wrote:
> > +	if (of) {
> > +		WARN_ON_ONCE((kn->flags & KERNFS_HAS_RELEASE) && !of->released);
> 
> kernfs_unlink_open_file() is also used in error case "err_put_node" in kernfs_fop_open(),
> which should also dec the on->nr_to_release?

Ah, right you're. Will fix. Thanks for pointing it out.

-- 
tejun
