Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179E1482451
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 15:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhLaO2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 09:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhLaO2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 09:28:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE6C061574;
        Fri, 31 Dec 2021 06:28:20 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d9so56360388wrb.0;
        Fri, 31 Dec 2021 06:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=VFAYdUcoAa/RBUsWThLomBm2E0VJ5Yt60qDK5YTAZfk=;
        b=KPYX8cg+tda3V0sVtzwIGGt0XtFxf16Cf1Zn+xhNJJVxKvi9XGHp0pjEaFDmAnGgyw
         sMRufT/CWxNO3H4nDN1BSxeVjk5cd0J954ht/zfP2BZU6rwy7w+kGqn6svX7btLeGbu+
         rsqdYRpg0+z+fTl+UIv1i3+lQZ97W6KcEKTWpxqbro161QMDbQdGL49+j8aBrplJjArp
         mnmzzcmgv2JQvmqCTn00oQEsLm1+OedUjDntBtW9d/nxAXwHlrXNuZPFkUSTD5dafGEZ
         iKH1Db9rkSkNtyrOgmIadd4NFRXqDbdvluYaccszVuKAqt7v+9u0kFF6EF5FEflEc2ne
         X7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=VFAYdUcoAa/RBUsWThLomBm2E0VJ5Yt60qDK5YTAZfk=;
        b=wGAt5lfafoEY2SnFIklOlkhTww/doScv83Vi/mlK7iUDHfa1bbAhK9eHeR02Ae7W0P
         StS+BYzgIthlyJ8s6o4OdhklH8esJwegNcc5Qo1rSwQruArwAw0pC2st3TCEJy1iT3Fp
         3aKH9vbSKz+gtSRY6ZE7G3vffSS6MWzFOG4GE3+El5ICuj0YRR4aadg6BUdFdbvstK7J
         qwdL/gpW1deoVgb5fZZ5hup9ZmtBgO2cxErHSJROY3ALea/qVyhssuCG9yz+DTRscn2A
         2RxbVTGpo8fUQfEyuFKoC2OJ7hV9NnvVAcaLxl2jPc1Yv8Dq7eepb09qRv4+/FUEeT3w
         N7ig==
X-Gm-Message-State: AOAM532FMJU2bTA7fGZaZHVsM7S7wzZJ8RDJ7Dd3Be36nUC2jEuTQIwk
        cleWT7soDNQzIPlYpnUjrvU=
X-Google-Smtp-Source: ABdhPJx509HsHEaDStY0QtfDvWKDZ29rDcRl4uEEatKD2J+vUb11UdBn6vX4OqFFFYebfAHSXaIjTg==
X-Received: by 2002:a05:6000:1549:: with SMTP id 9mr30108010wry.715.1640960899563;
        Fri, 31 Dec 2021 06:28:19 -0800 (PST)
Received: from [192.168.1.79] ([102.64.218.242])
        by smtp.gmail.com with ESMTPSA id c187sm29328745wme.33.2021.12.31.06.28.15
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 31 Dec 2021 06:28:19 -0800 (PST)
Message-ID: <61cf1383.1c69fb81.c166c.09c1@mx.google.com>
From:   Rebecca Lawrence <issatraorewassila@gmail.com>
X-Google-Original-From: Rebecca Lawrence
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello
To:     Recipients <Rebecca@vger.kernel.org>
Date:   Fri, 31 Dec 2021 14:28:12 +0000
Reply-To: ribeccalawrence@gmail.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Dear,
My name is Rebecca, I am a United States and a military woman who has never=
 married with no kids yet. I came across your profile, and I personally too=
k interest in being your friend. For confidential matters, please contact m=
e back through my private email ribeccalawrence@gmail.com to enable me to s=
end you my pictures and give you more details about me. I Hope to hear from=
 you soon.
Regards
Rebecca.
