Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13616E720E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 06:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjDSEDP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 00:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjDSEDO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:03:14 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A54244BE;
        Tue, 18 Apr 2023 21:03:11 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id d21so7285656vsv.9;
        Tue, 18 Apr 2023 21:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681876990; x=1684468990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx45rPwLqfgtKDOZUwfUqI6fPUf4VBZ4+4yBRD8TgUE=;
        b=IDiYXmv89HPq5fGs9scmyLz17lBWUr5UVCU21rnQUc1NPyZn4qYIf8F7Avzm0Sr0r5
         cyDRZqld6qxqYb0dReccgrt4mtV07LtGMQyjP1RL2qlA33xhUWMeOewFDGKVoxsX3rij
         oMMAEiR6Kb0X3N2d7AZtf5OyJfoHMEO5maqX72TbW+9hQpD3LzaSG2xIJ/IUKNzE8miW
         yOJw0Z3Z1gxcpqaeBXCcj26HmGoVgPoUvvek5CzlslpxU4W6SgyzV9RZXUtKOCO5QWhL
         U1GctQSLIzURtjtu7siKeZ8ISmbPTt9N6/ov297qwLwO3IQeE/spiC0yOg5G00ELI5sf
         NHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681876990; x=1684468990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx45rPwLqfgtKDOZUwfUqI6fPUf4VBZ4+4yBRD8TgUE=;
        b=IlRATXYcN25uIt4GY8nk/7d6RsyEFWt5mx+sBfUDOLU3AE2cBjzBNBTBj5Vpq8BADA
         WcziSjNUIl0f0KRTUx3lHHkP7XOId2RMJj3PUDH1qEAEXTMPLTysECNICoa0dW8WR68n
         u3fU+Yl2EZ0Gab5kyHzaUNQCcI2H6lhpmBJVzAbw3ixctgPB41U749qBZcXKG6rUSYno
         6TMMWU/wCU8MaDSD/vFyaFgkrw8B8DN/pNPTz3A4/XjQMjwJ6vIcnUmpstODvItwzZJv
         fEyI82K0d/H/K/4+hoLLOVVv27hnWXLR0k0idIo60ym5U3VSjn+UfK+mEcZTV1CWbA+o
         lpOQ==
X-Gm-Message-State: AAQBX9eMgx3d4k5YuIi0AnkVhOTK0R+x9VeJOnaU6fOMoN+mMrvRmahn
        6oNd57asrjvWOe0l2oB7S5Mvh0H7dpCbfKaAHkbrXaqy
X-Google-Smtp-Source: AKy350ZdaPvbfuvKfbzAmJqKEw5YuDOk/MSqV/3KM8gxmYkWFrg5b5hbge3owBPNrJ3yjo4gJLA2epZ04YUzsq5ISAA=
X-Received: by 2002:a67:d989:0:b0:42e:3bf8:1dbb with SMTP id
 u9-20020a67d989000000b0042e3bf81dbbmr10649908vsj.0.1681876990689; Tue, 18 Apr
 2023 21:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <Y/5ovz6HI2Z47jbk@magnolia> <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
 <20230418044641.GD360881@frogsfrogsfrogs> <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
 <ZD9hPSzEign05MTZ@casper.infradead.org>
In-Reply-To: <ZD9hPSzEign05MTZ@casper.infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Apr 2023 07:02:59 +0300
Message-ID: <CAOQ4uxjWQT5h7ck_AfEWiHCFNDxRWK45XP2kvxbreMPk5XJeig@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 6:34=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Apr 18, 2023 at 10:46:32AM +0300, Amir Goldstein wrote:
> > On Tue, Apr 18, 2023 at 7:46=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > > TBH, most of my fs complaints these days are managerial problems (Are=
 we
> > > spending too much time on LTS?  How on earth do we prioritize project=
s
> > > with all these drive by bots??  Why can't we support large engineerin=
g
> > > efforts better???) than technical.
> >
> > I penciled one session for "FS stable backporting (and other LTS woes)"=
.
> > I made it a cross FS/IO session so we can have this session in the big =
room
> > and you are welcome to pull this discussion to any direction you want.
>
> Would this make sense to include the MM folks as well?  Certainly MM
> has made the same choice as XFS ("No automatic backports, we will cc:
> stable on patches that make sense").

Yeh that makes sense.
Added MM to that session.

Thanks,
Amir.
