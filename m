Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5219B121EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfEBSeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 14:34:08 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:38465 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfEBSeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 14:34:08 -0400
Received: by mail-wr1-f41.google.com with SMTP id k16so4753091wrn.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtI5Tb9SFBI3B1ZJB/GXq7EgjI6y6AfHAArnGC6S7II=;
        b=YZubNvfw9f08VAVmYeysQ9beos02k15haIkRxMOFmawa+twb34tHDAQbpIGYDLf/ow
         5scMUVXNBgM+9R19bmM9rwONYjqDAO+8yXQMhaFMXC9+x+G8n5t6QC0ow02qqGvxSqnO
         p4B/3upKa4Dy2JinaA++qF5jn6tWzlevr0IGMztZRAZ2YX8T5yHXGI9DRGPIufdbiufc
         D3XqtIdFVuAGXbzt1/il2mFUasHbp5p1XYlBj0IH4vGo6IYGnmEhUt+0kp2yhuss8Om/
         mZDMUFUk8KSWKdj5ZYX04wKFB/VuaMAsq+wV6GkPq7jyN3xsnEgQKuvUYEuHjLyRZvHy
         rzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtI5Tb9SFBI3B1ZJB/GXq7EgjI6y6AfHAArnGC6S7II=;
        b=k90XIFfs7rZzgtRiuzxAnxDF77wI3tllvVToqVrRbd2y8NxVoQowCfSl7dB0Fyqiem
         HvSyBjwVEx4QDaSbvPBswXJT3et/vZ1fPi/20jVX+L0PEQPcCg5Z30HYKAld+5K2VnSO
         Fd8WHn+Q476FKkK4LLmtfHlQBEh8j3LiRQF6r7a7t30KpUdGIsbVf6ZwXmYwDQidXyWU
         lg8xCM+ZFrPy8rNUci25GBFdcXDwmUfM810HTKQcFujkNfguwxy0JJgTdgvTry+0DDyO
         mpQ2FgjKReSmKMbwfB5DvPoSX636x9Eo3YrWJlR6fhrbgj1aRlfjfcJATknPNlS6FyaC
         /zvA==
X-Gm-Message-State: APjAAAU3yWE8cjPO7y9k+OgR0OBK29XqSNepwIYwhiYxKB4eV8yN5WPC
        rEnHdQoJenV3YgjEoiE2ETfeQXOmXxsRFrV0IOE=
X-Google-Smtp-Source: APXvYqxnemZ2e4ppbL14WpVcnBspRgB/L+6moy8AKRGouftY1xWm19feySTLfd4DlRWcjMCCXtCpaNXUzjbeycD6yhY=
X-Received: by 2002:a5d:5343:: with SMTP id t3mr4022565wrv.262.1556822046255;
 Thu, 02 May 2019 11:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <CAFLxGvyfeuwhX=9Fu2XAoT7mxgKmr7T=238y8Mf8yAZnNXnOhg@mail.gmail.com>
In-Reply-To: <CAFLxGvyfeuwhX=9Fu2XAoT7mxgKmr7T=238y8Mf8yAZnNXnOhg@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 2 May 2019 20:33:55 +0200
Message-ID: <CAFLxGvzPTA89j2RZnYsaQTdpmfo_=Xnw7fs38fw4t0H=CHUneA@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     ezemtsov@google.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 8:16 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
> > Piling logic into the kernel is not the answer.
> > Adding the missing interfaces to the kernel is the answer.
>
> I wonder whether userfaultfd can but used for that use-case too?

...hit the send button too eary.

My thought is, userfaultfd is used to support live migration of VMs such that
pages from the remote side are loaded on demand.
Sounds a little like the android app use-case, hm?

The loader (ld-linux) runs the app and using userfaultfd missing pages
get downloaded on demand.

-- 
Thanks,
//richard
