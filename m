Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5275541DC35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbhI3O1R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348704AbhI3O1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:27:16 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E6BC06176C
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 07:25:34 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r9so7044950ile.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EBHbP83/CZFp2F2gENfmEXu6m8S2pw12piuqN6IlINY=;
        b=Gom9cmhuZtOCLi6En26A9lXhlwHxvJA2DkCQG+uBpdjV2VE53NSZg9tfU+z6MegnO4
         66FIXrCiBzogo3ei1SF58dARZgIFCfAYHbgz9wyWAXrbTCodmuY1f4Ymk3Phlcd2siaE
         i33LY734P80kdsp5jFbPB6eGxbPR+/ZcbK6lqML9Soqgk4kbmKgY6vnj1myDrRMZ2czB
         M9ARTWajLw7AvhTMyjf5oRyCat4ylnQnwcRtNbABbndEczInkL/6irbqnk+5CEbZuSbO
         EXZuSuVPScZONoc44GMVj+f5kJNz9DyH+TnxCXHvp6eP73ctZ1B98OjpJd8C3N421fVq
         y4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EBHbP83/CZFp2F2gENfmEXu6m8S2pw12piuqN6IlINY=;
        b=ZhwWDZh2MOtKAm0yzB3Z7WSEw8Qlt825pJ979Ocfs+hma1BWlCeJAk18sc4hg8cy3o
         T9C3oQqb9ECgZiiaRv9mGCOHoC4y52GIrnh+uyHIUU8FNU3KhWq/ZTMeyWGqx5aNsOZz
         YiThnbE+XU4axaPt6AygibNDYt1xhgz48MxaxYNB1CA00MbeFm7iLCYtKd9qd3hv6nBL
         8s5lRzOL9xaQAddm1h2tl0kdN96Cu3zerHkbHXSu5nxQ+8DhCYlWyE9HtGgowPRZNUdM
         vCrtsUZQp3hRjuqD3LYB91xeINpEzAnC8V4D7vLMzSLv8xC9IFT/DmDTEHi9V8TSUUCI
         v86Q==
X-Gm-Message-State: AOAM531rS2JMiz8z8D/MEBKPX1TBoBHYd/+t3+qvg5vxOIWQ7mLUGsAR
        65xPASPE0EgnaKTiEC8592SUctGzlDCbnz0ANg==
X-Google-Smtp-Source: ABdhPJw32tMf1ycOiwZxOS0uFoXXOsW1tVlGKyEQVci0X/JdxISH/6GQNrzRN9z+90TNj3PiR77XXAcogd4YcIM3dZI=
X-Received: by 2002:a05:6e02:134e:: with SMTP id k14mr4465066ilr.39.1633011933385;
 Thu, 30 Sep 2021 07:25:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:f6c7:0:0:0:0:0 with HTTP; Thu, 30 Sep 2021 07:25:32
 -0700 (PDT)
Reply-To: tonysiruno9@gmail.com
From:   Tony Siruno <tunkaraa7@gmail.com>
Date:   Thu, 30 Sep 2021 14:25:32 +0000
Message-ID: <CAA=Fp1RP3x8Zvdr73mRFJzzhSx5gkZaGEK2GNyWG43khTvyirg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Warum schweigen Sie? Ich hoffe, es geht Ihnen gut, denn jetzt habe ich
Ihnen diese Mail zweimal gesendet, ohne von Ihnen zu h=C3=B6ren. Heute
komme ich von meiner Reise zur=C3=BCck und Sie schweigen =C3=BCber die Post=
, die
ich Ihnen seit letzter Woche gesendet habe. Bitte lassen Sie mich Ich
kenne den Grund, warum Sie geschwiegen haben. Ich habe mir
vorgestellt, warum Sie mir nicht sehr wichtig geantwortet haben.
Bitte, Liebes, ich brauche Ihr ehrliches Vertrauen und Ihre Hilfe. Mit
meiner guten Absicht kann ich Ihnen vertrauen, dass Sie die Summe von
12.500.000,00 Millionen US-Dollar in =C3=BCberweisen Ihr Konto in Ihrem
Land, wenn m=C3=B6glich, melden Sie sich bei mir, um weitere Informationen
zu erhalten. Ich warte auf Ihre Antwort und bitte lassen Sie es mich
wissen, als zu schweigen.

Herr Tony Siruno.
