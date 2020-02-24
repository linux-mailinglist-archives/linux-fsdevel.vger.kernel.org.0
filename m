Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD8716A4D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 12:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBXLZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 06:25:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38270 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXLZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:25:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O87YYb160437;
        Mon, 24 Feb 2020 08:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=6qKJx4gzfpljmcOcHGiZyzYN7Uu40KJ6LMB+X9Hu3pM=;
 b=XyvGvgkMuU4oe4Kzr5MzIxqxC+MueWnjd1wupeXsL9K9hXTjjJ6cIu4lDsnEob+ZeSLO
 bAazjaqCAshQfY2xw1WvrBuTF54mzLT8+JRflg74v7DZCg6dJnLBBU0TN7y8p9tZ0UN3
 yPWVNQHZltckspOi/qND1jd7zQw0PDfhL20h482qprLNvVhTjFutQ1eWB46kc22OhSeB
 4RfxIcLwMZHi3bNkQuV3LoLYsAclXmH9jfdJa3f1fv3zX5ok+ATBKwRBNKJLfn0eXdAh
 NJxkNQ33cwRn1beht/VJWiNTl5fP1UIyZZc2HIGo/ScUc490uAZP21v0Xzbux6HIAZTy nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ybvr4hw5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 08:09:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01O87q9q182572;
        Mon, 24 Feb 2020 08:09:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ybe10nc98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 08:09:03 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01O88xmR024337;
        Mon, 24 Feb 2020 08:08:59 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 00:08:59 -0800
Date:   Mon, 24 Feb 2020 11:08:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v2 3/7] test_firmware: add partial read support for
 request_firmware_into_buf
Message-ID: <20200224080842.GA3308@kadam>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-4-scott.branden@broadcom.com>
 <20200220084255.GW7838@kadam>
 <9afab7f8-1b5f-a7bb-6b76-f7b19efb2979@broadcom.com>
 <4a666590-461d-17f9-5580-31a41869383f@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a666590-461d-17f9-5580-31a41869383f@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9540 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240071
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:13:08PM -0800, Scott Branden wrote:
> > > > +static ssize_t test_dev_config_show_size_t(char *buf, int cfg)
> > > > +{
> > > > +    size_t val;
> > > > +
> > > > +    mutex_lock(&test_fw_mutex);
> > > > +    val = cfg;
> > > > +    mutex_unlock(&test_fw_mutex);
> > > Both val and cfg are stack variables so there is no need for locking.
> > > Probably you meant to pass a pointer to cfg?
> I am following the existing code as was done for
> test_dev_config_show_bool(),
> test_dev_config_show_int(),
> test_dev_config_show_u8()

Heh.  Yes.  Those are buggy as well.  Good eyes.  Could you send a patch
to fix them?

regards,
dan caprnter

