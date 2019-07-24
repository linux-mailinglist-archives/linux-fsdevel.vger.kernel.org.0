Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D66973551
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfGXRZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 13:25:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36503 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGXRZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:25:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so21556948pgm.3;
        Wed, 24 Jul 2019 10:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v5o93rppXWOEe1khDbdKPwUWVhMWimUKdS1T4a7dv9A=;
        b=IFEoXTVgZ4ICjhndw6Yg/eu4xfo/TSctxWBfUswClSV6OJ6k2joYbp2ljUIUS14hRV
         jC+yWEiBcGQEORnde4IDcsdaLKYxQMzISlPZaqgyw38cUFM4S3FrE+gRTw6CUu98QhLg
         ezJMqLhRl+Y2QleD+FeaJ/u1HBDF5pG0Ki3UkheZpb1G0N4/mvVj+NPfGRj99XGFz80H
         CZDPsmfd4pr0d9Fdq7FKWSvzQtPilcj2nuLocSACIGRjta+BuL6BcjJtYzXs3FqRDuM0
         ZDe1Nyvb8As26aPZnPpjaoa9U+qwxZq6y5RfRO+3jzBxBa99meP9yy37R75p5kfNpSMP
         dDMw==
X-Gm-Message-State: APjAAAViAG2DKaROHFTYa5MuO2kXID/zSt4+rjWxVX8wLc2afryDH0f1
        Jo1Fb8I7OwIBRBr54I3+Shg=
X-Google-Smtp-Source: APXvYqz8XfN6M40/6fe7BxMTCZJQCCPcbWguJPVyb/SH7u8lYYU33WfbbFpre78nAUrnVv5x6QkoeQ==
X-Received: by 2002:a17:90a:bd93:: with SMTP id z19mr89794097pjr.49.1563988666568;
        Wed, 24 Jul 2019 10:17:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id t10sm46821994pjr.13.2019.07.24.10.17.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 10:17:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1E29A402A1; Wed, 24 Jul 2019 17:17:45 +0000 (UTC)
Date:   Wed, 24 Jul 2019 17:17:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH REBASE v4 00/14] Provide generic top-down mmap layout
 functions
Message-ID: <20190724171745.GX19023@42.do-not-panic.com>
References: <20190724055850.6232-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724055850.6232-1-alex@ghiti.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Other than the two comments:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
