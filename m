Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445686140B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 23:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJaWbD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 18:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaWbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:31:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5490213EB3;
        Mon, 31 Oct 2022 15:31:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id io19so11977770plb.8;
        Mon, 31 Oct 2022 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRvSxv/dMXK9FkZdU40r1Y99Us3P1pzd7oqWG3jSj48=;
        b=VUE9w0WvnMs8KMSmXmMyerO/xwsIP2cTNHqOj+IkFjDI9we0eVx4T8GpUYOBgwzc3d
         u3f2QVAZSqg1DfrYDBCFzkSf/Iv4yA+CwHF2EHJQKHBZ3mkyky19zOuMRGKuBDZuqAlD
         U+FfDtBEJYz2qtRwA2r8Vb1F1LEXbbXNbEnZiBkjh5wdccrWiV5VT2JpOvDVSIKTtkpV
         FTUIZBz9VQe5rKAzqYoj5vdtVrxodkvbBXAdiE/LCl+tD2NDdmFSj0jfCLbWJWeyTpg9
         kFsBpRyW71bPYxQHRZZ3GV7cVSdQpfuCsgOoEQQEILn/2/JwmeNDinDM6opsZjXTzwSm
         5ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRvSxv/dMXK9FkZdU40r1Y99Us3P1pzd7oqWG3jSj48=;
        b=b8CJuiu5C3y+dbmxE8TTxg8LB9pfsto/2281cCBy0IejuBcHBpjtOYXioUBr5tBFXo
         UoXxZUAOk4mbPIQ/qjoima4kT8R2vl9ZYcgO9UX3nr7ClJWduJtc1bCE/YaS0+fkZ+3u
         NawvOpKxk6rPvrr6LIlCqacszwAahXaHtxghbYN4u21pnWoieR47w47My9zkz5BTmIaM
         PhrirzS73MlXDNWNGBYTHRPD8au9Gjp7ibFjMxfwt1GZ3sdrDQBSS7Nn8NmO6xi7SWoK
         2lAN6nBSuYgqkmewHtFGcgUcPjkbd9U0GYrhZ2NABeMPHv2ruB20U5YMQfNFejUVinZ1
         veHg==
X-Gm-Message-State: ACrzQf29W/WLyHnCxVzUEh6NSrwB5dVorAhJWTGfLH2qU1TFwsXURr6U
        GqN/cRNrgFjj71eT/QhY17C5/ZlGoy8=
X-Google-Smtp-Source: AMsMyM5ki2u6Yq+CGRDtdrvs2/VY+2MeRXeJnEBEspHTSeELGZPsnrRox5gQhNtNkO9/QzoHaf07TQ==
X-Received: by 2002:a17:90b:33d0:b0:213:137b:1343 with SMTP id lk16-20020a17090b33d000b00213137b1343mr17175534pjb.128.1667255460698;
        Mon, 31 Oct 2022 15:31:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id r13-20020a63204d000000b004308422060csm4568309pgm.69.2022.10.31.15.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 15:31:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 12:30:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kernfs: dont take i_lock on inode attr read
Message-ID: <Y2BMonmS0SdOn5yh@slm.duckdns.org>
References: <166606025456.13363.3829702374064563472.stgit@donald.themaw.net>
 <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166606036215.13363.1288735296954908554.stgit@donald.themaw.net>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:32:42AM +0800, Ian Kent wrote:
> The kernfs write lock is held when the kernfs node inode attributes
> are updated. Therefore, when either kernfs_iop_getattr() or
> kernfs_iop_permission() are called the kernfs node inode attributes
> won't change.
> 
> Consequently concurrent kernfs_refresh_inode() calls always copy the
> same values from the kernfs node.
> 
> So there's no need to take the inode i_lock to get consistent values
> for generic_fillattr() and generic_permission(), the kernfs read lock
> is sufficient.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
