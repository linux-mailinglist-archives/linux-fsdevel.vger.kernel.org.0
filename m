Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD58599488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 07:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346116AbiHSFYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 01:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346025AbiHSFYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:24:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3337D598E;
        Thu, 18 Aug 2022 22:24:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x21so4369750edd.3;
        Thu, 18 Aug 2022 22:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=xR2elTYWv0Zzv2c1Y+xBuQNNDUv6x050YIaLAIcv7mk=;
        b=kDIyznJTIUMQDpgkng65TVs3ysH2Ap8U62FxMrOAtMy6fx8DEwEqtKpbq0d18/HpM5
         RKNzEwqY8rkYzTinNPQZ1EprTtNQaNvBrpljxyT7pc00Fk9FT9fw4cwDZMFFcY68nCTp
         XToD9c8W9iq60+PbQerdoVYGURhM+wA0lsFukqx6WfIbGy4dxwJZD29oxuNMPV4u48MZ
         NGuJPtgM+Fh7fCwBjL528xwy7b2HnfxGJFv7F6mxjvIJDKWB2OvJIwd0bw4hxkwTR/Ki
         6nIxA2bqKfQfobL0se5tRlhJvqAN22+saxk5dyiSED2AX93z8tJ8Ip9QZhXLeLhjhfsU
         7F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=xR2elTYWv0Zzv2c1Y+xBuQNNDUv6x050YIaLAIcv7mk=;
        b=GiggHnRkETru5GtbItKrweV69UPbge+gCjZX3nG+KYwujd1Kazxkv2lWTiLBnpPkxM
         zm78g0A1v2g+0fUXNcLHe3GeYLCcEKtX6+UNwMvo7RE6U1kMvrcXH8x3of6iy0OKI+VN
         qvZSaG0mQf4eTxXqgfQiT/BWGPCliIzTyGg0o1KYEGE2aMHOHvQ9SFZou0s1bnyyaUrL
         bOYlKvDiPD9Jx4eFSayTJgWYFvCprPFR81oojMgP6hZkhbImWyL6puVcTuXK443wGtqS
         hZc9QD4W40YNtk9z45wUeK7m4lzLXU9GZfZ2utRYxFlze924gNr+aZOLpWCXl6qZThkp
         wzNg==
X-Gm-Message-State: ACgBeo0eANtWWMlJXM2KBOGuifPIA/a+4GR6VA0U+G6XE8y2ZDnc5JTv
        NfkbBEZ/Q1nUiaPGx6fMz0Y=
X-Google-Smtp-Source: AA6agR67UVTNCb4Y0rPq1rIbu/3wWl3E10Npve36SEF0suEvj2HEBIG9lFUvIOxKHKrdpZD3ATAeug==
X-Received: by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id r7-20020aa7cb87000000b0043be6506036mr4785812edt.350.1660886681133;
        Thu, 18 Aug 2022 22:24:41 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id ev6-20020a17090729c600b007389c5a45f0sm1768514ejc.148.2022.08.18.22.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:24:40 -0700 (PDT)
Date:   Fri, 19 Aug 2022 07:24:38 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v5 2/4] selftests/landlock: Selftests for file truncation
 support
Message-ID: <Yv8elmJ4qfk8/Mw7@nuc>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <20220817203006.21769-3-gnoack3000@gmail.com>
 <e90aaa5d-d6c8-838a-db29-868a30fd8e37@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e90aaa5d-d6c8-838a-db29-868a30fd8e37@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:39:27PM +0200, Mickaël Salaün wrote:
> On 17/08/2022 22:30, Günther Noack wrote:
> > +/*
> > + * Invokes creat(2) and returns its errno or 0.
> > + * Closes the opened file descriptor on success.
> > + */
> > +static int test_creat(const char *const path, mode_t mode)
>
> This "mode" argument is always 0600. If it's OK with you, I hard code this
> mode and push this series to -next with some small cosmetic fixes.

Yes, absolutely. Please do these fixes and push it to -next. :)

Thanks,
—Günther

--
