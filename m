Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D14EDF24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbiCaQzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbiCaQz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:55:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75641255B0;
        Thu, 31 Mar 2022 09:53:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so3481111pjb.0;
        Thu, 31 Mar 2022 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BeeYtJ246l+bProXtw2lWm1PZwxv2zffBYuHYauJMQc=;
        b=jf2RYyS6NTKssnJlBHDO0FSAHT56A8HTbN8DbbiTRRit2/vE31RN6973NUnu3hXanM
         rASkPkc7h2tnOBB+B8A1Q+ezP6lTL0WpB4o8lYEKGaCRY2eefT/+dnxJBFj74czuk/kc
         v3d3QPntj2f2fQVyz84kBmLncSZX35HOTDTsMxvT2G3Ey8Gy4CS5JoI4rvKlbcFWqF1P
         LgQ4aA/8PWRAJXK8s9PbNgXdBZ+Hu02D+eZ/6YgqoYXhEsmh0/+olEfMRmMSxhXA8AxK
         x/lKOXqa9f4ivIudb3i3VdI5wS0YOnR+JOwwpkvw/gj5//jd7dQNfEVSUXVw3wwwQTF3
         vLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BeeYtJ246l+bProXtw2lWm1PZwxv2zffBYuHYauJMQc=;
        b=kswn3EV98/DxtGrzxnS7nm7Mj77E2tr9+DeCr6SwZCNCdrTXjqqHBp9uTytSdKAzvo
         hOGue2cJm9ArRLUsX+FMBlih+rWGKYAuoDtYPledu4XTa41oqB5lEfHvz366L/oGQsnO
         RB9/G5UlvCcBhwaY6JNHlT8+7TpOPkT6bADapVTCPtjF4MmDg3YmGMJ1EHQslRwde1mF
         jTnPnDnE9pfs7tSOK2pav+TVaUM4TYwmcwwFAsbQqeqPNSr+HsWkei7v5tQKBhsiZvFe
         kNowXEeNWi/CJduK5SCGuINhO5FglM7QXkGO52sAAFKpNH7znFRdMud+h22vJTPjdKkG
         qfPA==
X-Gm-Message-State: AOAM532ZA75t474rjiR5YWTO2K86jbmgzIzrYejO1lsOK3FzqcI05fRE
        7zDQgX3sFxAfqdi863sZg/SWiJDpmvg=
X-Google-Smtp-Source: ABdhPJw+gjIAYweZEJzMk+eNXb/tdfecBoIEp3rNe5P7PWQciyyQ1BoSgiRodfLoNhfp3AoEzXBpQw==
X-Received: by 2002:a17:902:6bc4:b0:154:6b3d:a720 with SMTP id m4-20020a1709026bc400b001546b3da720mr6218875plt.104.1648745620974;
        Thu, 31 Mar 2022 09:53:40 -0700 (PDT)
Received: from localhost ([2406:7400:63:7e03:b065:1995:217b:6619])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001b9c05b075dsm9860162pju.44.2022.03.31.09.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:53:40 -0700 (PDT)
Date:   Thu, 31 Mar 2022 22:23:35 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
 <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/31 09:49PM, Ritesh Harjani wrote:
> On 22/03/31 10:59PM, Zorro Lang wrote:
> > On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> > > Hello,
> >
> > Hi,
> >
> > Your below patches looks like not pure text format, they might contain
> > binary character or some special characers, looks like the "^M" [1].

Sorry to bother you. But here is what I tried.
1. Download the mbx file using b4 am. I didn't see any such character ("^M") in
   the patches.
2. Saved the patch using mutt. Again didn't see such character while doing
	cat -A /patch/to/patch
3. Downloaded the mail using eml format from webmail. Here I do see this
   character appended. But that happens not just for my patch, but for all
   other patches too.

So could this be related to the way you are downloading these patches.
Please let me know, if I need to resend these patches again? Because, I don't
see this behavior at my end. But I would happy to correct it, if that's not the
case.

-ritesh
