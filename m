Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B15B1873AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 20:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbgCPTzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 15:55:43 -0400
Received: from mail-qv1-f45.google.com ([209.85.219.45]:41492 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732467AbgCPTzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:55:42 -0400
Received: by mail-qv1-f45.google.com with SMTP id a10so9574310qvq.8;
        Mon, 16 Mar 2020 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2N1eGqL++dHn9tEiH6VJwCetZrqpDOiEdM+2W5iU3ms=;
        b=S1NjRsNCn4oalrekycXgaV8BfxJ15lcoIiCBx9/Yf6rGN1LibEg0IfvlT3gouVDP0z
         p9d8BlEDD5ATlq0TpVZSZTG+y+0z6LSP9y6RR38YOS/eFO3lufuQxn/rIji5Hvf+JjKe
         xURhABe83mZjtF4FMCX2k/+XFH6b+l0SnyTKSsydshKZSvSIYIPqijYHLzOCGAGErYi7
         8UskBwoO+A9HmKiIy7xds87DZdHKeIvZEu+quMa9MOOIu/38vYnP9jNap+S3cgMtTTJO
         mym2Mbo+ZgDMi0BKb0PMTCbNMy8NAcTQKw5uZqmV6Dw+HQ8+jGNvZba2HyeISfJVQf8I
         S1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2N1eGqL++dHn9tEiH6VJwCetZrqpDOiEdM+2W5iU3ms=;
        b=RtshbRB2P1ZmSwdD8zJ1hqhn4UiTVd9WkJ0u/2SUokbWw7A8rliptrLETfr+kW/hNB
         tiM/EXcCdSwfmWcd8q6o53WlATotJvVaLUw+drQUlQwG9Q9y7EgkPf/yGFgxMModxXmg
         I02qvv+kPH+MsBH9NPm8Pel/ui6fd8m5v5J+OohhE4vIP6Ayipm4kDjWT5I48ZxTSSou
         Jay0eIHY9uLJYZd14abE53wkVz/C8vcM1IcvOz7l9MkJRxPkjck/1iMGYaBXqR5hlE6o
         7UgKoWqqO0avZU3LT53VxwWndvZ+yY+ZEKLpFQkt3E8uUr7hcks+j2ndfhRMEv4gFzTr
         O03Q==
X-Gm-Message-State: ANhLgQ00pGmbXQmg1VVR+bnAkMBWCOLb29BjXoEXUnKUnYHoB0DkME7C
        u/cO+DY4O1dCUCB/ofCFSpc=
X-Google-Smtp-Source: ADFU+vvwKU25T3MJSAcyQ7qgmu5yO5WCx6quPI74iDZNBKnpJxVy8zdvWxdUD8LYhblLeYfclLyH3Q==
X-Received: by 2002:ad4:51c7:: with SMTP id p7mr1483281qvq.125.1584388541352;
        Mon, 16 Mar 2020 12:55:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:cbe5])
        by smtp.gmail.com with ESMTPSA id y17sm569880qth.59.2020.03.16.12.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:55:40 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:55:39 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        viro@zeniv.linux.org.uk, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/4] Support user xattrs in cgroupfs
Message-ID: <20200316195539.GD1967398@mtj.thefacebook.com>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312200317.31736-1-dxu@dxuuu.xyz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Applied to cgroup/for-5.7.

Thanks.

-- 
tejun
