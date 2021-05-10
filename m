Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57061379524
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 19:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhEJROm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhEJROl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 13:14:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59626C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 10:13:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v12so17395866wrq.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O/ahEFFtBnl2BGdakViW29AbESfG+m7IiwTXfL+9OuE=;
        b=hKfi9ivlS5bjNpIbVRFA6BzX/NhKCTCS1qZ4CWbeujHfo2ivg2amTv7u18yVc933jM
         EPEDG9JryPfjwQcNDXN+ejk7KvN5RihdsamBC8UuH+2jXlCzXPbfTLOaNvaAugVbkT6S
         8JLHa/E5dfRUp1MdTeioEIpVAwOQKxJg/aBnw8Mhf9V9o0EZetB6QxzmfQz6fAfSo5jg
         pG1cBMQSSNBNcakhButlO9HVbNQVYal0pId8z851FFhMGpMJlwBESMeN75mFG6P0e/T1
         QfbNiivOU0Vp0Iwcmm/9FEH8cmJYHXtauxoKJMO0sVCJpLnmrzyfvhxdhS0gzjOtm1M6
         aQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/ahEFFtBnl2BGdakViW29AbESfG+m7IiwTXfL+9OuE=;
        b=OvIgPekz5+enusTfUbhx7hwjBozwISJc50oY9qZlw1P0ZMumWfgsitw//xYkUOCQV0
         vefSxuh//t7zV+UPxtie/bDnnMKIa04tnN+OovO/gJur+tn6vrnHgJ1Pyl2Ep2G8IIOa
         qe+IGyUrDNia+frRs3IosxhOA/SAqhFAVAPGqBRlc97nds+YGEoFHV4Hc5tjM8UxayOD
         8jxt/uXJtacqfq83iNUwhsxwKFC3unAyoGrtK6e4gWp51+9yPIrUJl5fyhhUYEKuDI28
         HrIVIUVYG8PtooFeFJS7D2JduhNX4I25DuMpeH6GgEbIsbBonbhEVCN03Ju0QdYzUO7u
         /Osg==
X-Gm-Message-State: AOAM5323DT0U8fxJMml00pVUj0zzENp+pJSD+/yADeC4E4uHgNbD6hm1
        h8/GmnBGbPjNGhsY+bUV+nJFUVkTOA==
X-Google-Smtp-Source: ABdhPJwF6ubKbnpwQoo9SUIBwq7H+W7QAhN6uxckxyOnR/m9A1yRFmmgXpRLQrav3d1eWNjaFG8ijA==
X-Received: by 2002:a5d:6383:: with SMTP id p3mr31833573wru.230.1620666814150;
        Mon, 10 May 2021 10:13:34 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.42])
        by smtp.gmail.com with ESMTPSA id f6sm25446522wru.72.2021.05.10.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:13:33 -0700 (PDT)
Date:   Mon, 10 May 2021 20:13:32 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     youling257 <youling257@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] proc: convert everything to "struct proc_ops"
Message-ID: <YJlpvAXwpFtVlcy9@localhost.localdomain>
References: <20191225172546.GB13378@avx2>
 <20210510134238.4905-1-youling257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210510134238.4905-1-youling257@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 10, 2021 at 09:42:38PM +0800, youling257 wrote:
> Hi, my xt_qtaguid module need convert to "struct proc_ops",
> https://github.com/youling257/android-4.9/commit/a6e3cddcceb96eb3edeb0da0951399b75d4f8731
> https://github.com/youling257/android-4.9/commit/9eb92f5bcdcbc5b54d7dfe4b3050c8b9b8a17999
> 
> static const struct proc_ops qtudev_proc_ops = {
> 	.proc_open = qtudev_open,
> 	.proc_release = qtudev_release,
> };
> 
> static struct miscdevice qtu_device = {
> 	.minor = MISC_DYNAMIC_MINOR,
> 	.name = QTU_DEV_NAME,
> 	.fops = &qtudev_proc_ops,
> 	/* How sad it doesn't allow for defaults: .mode = S_IRUGO | S_IWUSR */
> };
> 
> I have problem about ".fops = &qtudev_fops,", convert to ".fops = &qtudev_proc_ops," is right?

No! Those remain file_operations driving your device.
How is it supposed to work otherwise?
